import { dz_shot } from './../../../../node_modules/.prisma/client/index.d';
import { PrismaClient } from '@prisma/client';
import express from 'express';
import { wrapAsync } from '../../../shared/functions';
import { JSend } from '../../../shared/jsend';

const prisma = new PrismaClient();
const router = express.Router();

router.post('/lineup', wrapAsync(async (req: any, res: any) => {
  const { team_id, game_ids } = req.body;
  if (!team_id || !Array.isArray(game_ids) || game_ids.length === 0) {
    return res.status(400).json(JSend.fail('Parametri mancanti o errati: team_id o game_ids'));
  }

  const allLineups = await prisma.$queryRawUnsafe<any[]>(`
    SELECT team_id, game_id, lineup_hash, seconds_start, seconds_end
    FROM v_play_lineup_window
    WHERE team_id = ${team_id}
      AND game_id IN (${game_ids.join(',')})
  `);

  const lineupMap = new Map<string, { players: number[], minuti_giocati: number }>();

  for (const row of allLineups) {
    const playerIds = row.lineup_hash.split('-').map((x: string) => Number(x)).sort((a: any, b: any) => a - b);
    const normalized = playerIds.join('-');
    const minutes = (row.seconds_end - row.seconds_start) / 60;

    if (!lineupMap.has(normalized)) {
      lineupMap.set(normalized, { players: playerIds, minuti_giocati: 0 });
    }
    lineupMap.get(normalized)!.minuti_giocati += minutes;
  }

  const topLineups = Array.from(lineupMap.values())
    .sort((a, b) => b.minuti_giocati - a.minuti_giocati)
    .slice(0, 10);

  const allSubPlays = await prisma.$queryRawUnsafe<any[]>(`
    SELECT sp.*, (p.seconds_start + sp.seconds_da_start) AS action_time, p.game_id
    FROM sub_play sp
    JOIN play p ON p.id = sp.play_id
    WHERE p.game_id IN (${game_ids.join(',')})
  `);

  const allIntervals = await prisma.player_team_game_play.findMany({
    where: {
      team_id: team_id,
      game_id: { in: game_ids }
    },
    select: {
      player_id: true,
      game_id: true,
      seconds_start: true,
      seconds_end: true
    }
  });

  const dzShots = await prisma.$queryRawUnsafe<any[]>(`
    SELECT *
    FROM dz_shot
  `);

  const allPlayers = await prisma.player.findMany({
    where: {
      id: {
        in: topLineups.flatMap(l =>
          [l.players[0], l.players[1], l.players[2], l.players[3], l.players[4]].map(Number)
        )
      }
    },
    select: {
      id: true,
      name: true,
      surname: true,
      logo_url: true
    }
  });

  const result: any[] = [];

  for (const lineup of topLineups) {
    const playerIds = [
      Number(lineup.players[0]),
      Number(lineup.players[1]),
      Number(lineup.players[2]),
      Number(lineup.players[3]),
      Number(lineup.players[4])
    ];

    const playerInfos = playerIds.map(id => {
      const p = allPlayers.find(pl => pl.id === id);
      return p ? {
        id: p.id,
        name: p.name,
        surname: p.surname,
        logo_url: p.logo_url
      } : {
        id,
        name: 'Unknown',
        surname: '',
        logo_url: ''
      };
    });
  
    const matchingSubPlays = allSubPlays.filter(sp => {
      const intervalsThisGame = allIntervals.filter(iv => iv.game_id === sp.game_id);
      return playerIds.every(pid => {
        return intervalsThisGame.some(iv =>
          iv.player_id === pid &&
          iv.seconds_start && sp.action_time >= iv.seconds_start &&
          iv.seconds_end && sp.action_time <= iv.seconds_end
        );
      });
    });
  
    const stats = {
      player1: playerInfos[0],
      player2: playerInfos[1],
      player3: playerInfos[2],
      player4: playerInfos[3],
      player5: playerInfos[4],
      fouls_committed: 0,
      fouls_received: 0,
      points: 0,
      made_2pt: 0,
      missed_2pt: 0,
      pct_2pt: 0,
      made_3pt: 0,
      missed_3pt: 0,
      pct_3pt: 0,
      made_ft: 0,
      missed_ft: 0,
      pct_ft: 0,
      off_reb: 0,
      def_reb: 0,
      blocks_made: 0,
      blocks_suffered: 0,
      turnovers: 0,
      steals: 0,
      assists: 0,
      minutes_played: lineup.minuti_giocati
    };

    for (const sp of matchingSubPlays) {
      const shot = dzShots.find(ds => ds.id === sp.shot_id);

      // Fouls
      if (sp.foul_id && playerIds.includes(Number(sp.player_made_id))) {
        stats.fouls_committed++;
      }
      if (sp.foul_id && playerIds.includes(Number(sp.player_suffered_id))) {
        stats.fouls_received++;
      }

      // Points and shots
      if (shot && playerIds.includes(Number(sp.player_made_id))) {
        if (shot.made_01 === '1') {
          stats.points += shot.point;

          if (shot.point === 2) stats.made_2pt++;
          else if (shot.point === 3) stats.made_3pt++;
          else if (shot.point === 1) stats.made_ft++;
        } else {
          if (shot.point === 2) stats.missed_2pt++;
          else if (shot.point === 3) stats.missed_3pt++;
          else if (shot.point === 1) stats.missed_ft++;
        }
      }

      // Rebounds
      if (sp.rebound_offensive_01 === '1' && playerIds.includes(Number(sp.player_made_id))) {
        stats.off_reb++;
      }
      if (sp.rebound_defensive_01 === '1' && playerIds.includes(Number(sp.player_made_id))) {
        stats.def_reb++;
      }

      // Blocks
      if (sp.blocks_01 === '1' && playerIds.includes(Number(sp.player_made_id))) {
        stats.blocks_made++;
      }
      if (sp.blocks_01 === '1' && playerIds.includes(Number(sp.player_suffered_id))) {
        stats.blocks_suffered++;
      }

      // Turnovers and steals
      if (sp.turnover_id && playerIds.includes(Number(sp.player_made_id))) {
        stats.turnovers++;
      }
      if (sp.turnover_id && playerIds.includes(Number(sp.player_suffered_id))) {
        stats.steals++;
      }

      // Assists
      if (sp.assist_01 === '1' && playerIds.includes(Number(sp.player_made_id))) {
        stats.assists++;
      }
    }

    // Calculate percentages
    const total2pt = stats.made_2pt + stats.missed_2pt;
    const total3pt = stats.made_3pt + stats.missed_3pt;
    const totalFt = stats.made_ft + stats.missed_ft;

    stats.pct_2pt = total2pt > 0 ? Math.round((stats.made_2pt * 100) / total2pt * 10) / 10 : 0;
    stats.pct_3pt = total3pt > 0 ? Math.round((stats.made_3pt * 100) / total3pt * 10) / 10 : 0;
    stats.pct_ft = totalFt > 0 ? Math.round((stats.made_ft * 100) / totalFt * 10) / 10 : 0;

    result.push(stats);
  }

  res.status(200).json(JSend.success(result));
}));

router.post('/lineup-by-minute', wrapAsync(async (req: any, res: any) => {
  const { game_id } = req.body;

  if (!game_id) {
    return res.status(400).json(JSend.fail('Parametro mancante: game_id'));
  }

  // Prendi le lineup della partita
  const lineupWindows = await prisma.$queryRawUnsafe<any[]>(`
    SELECT game_id, team_id, lineup_hash, seconds_start, seconds_end
    FROM v_play_lineup_window
    WHERE game_id = ${game_id}
  `);

  // Mappa lineup per team
  const teamsMap: { [teamId: number]: { seconds_start: number; seconds_end: number; lineup: number[] }[] } = {};

  for (const lw of lineupWindows) {
    const playerIds = lw.lineup_hash.split('-').map((id: string) => Number(id)).sort((a: any, b: any) => a - b);
    if (!teamsMap[lw.team_id]) teamsMap[lw.team_id] = [];
    teamsMap[lw.team_id].push({
      seconds_start: lw.seconds_start,
      seconds_end: lw.seconds_end,
      lineup: playerIds
    });
  }

  const teamIds = Object.keys(teamsMap).map(Number).sort((a, b) => a - b);
  const teamA_id = teamIds[0];
  const teamB_id = teamIds[1];

  // Tutti gli ID giocatori coinvolti
  const allPlayerIds = Array.from(
    new Set(lineupWindows.flatMap(w => w.lineup_hash.split('-').map((id: string) => Number(id))))
  );

  const allPlayers = await prisma.player.findMany({
    where: { id: { in: allPlayerIds } },
    select: {
      id: true,
      name: true,
      surname: true,
      logo_url: true
    }
  });

  const playerMap = new Map<number, any>(allPlayers.map(p => [p.id, p]));

  const result: {
    minute: number;
    teamA_players: any[];
    teamB_players: any[];
  }[] = [];

  let prevLineupA: number[] = [];
  let prevLineupB: number[] = [];

  for (let minute = 0; minute < 40; minute++) {
    const second = minute * 60 + 1;

    // Trova lineup valide per A e B in questo minuto
    const windowA = teamsMap[teamA_id]?.find(w => second >= w.seconds_start && second <= w.seconds_end);
    const windowB = teamsMap[teamB_id]?.find(w => second >= w.seconds_start && second <= w.seconds_end);

    const lineupA = windowA?.lineup || [];
    const lineupB = windowB?.lineup || [];

    const teamA_players = arraysEqual(lineupA, prevLineupA)
      ? []
      : lineupA.map(id => playerMap.get(id)).filter(Boolean);

    const teamB_players = arraysEqual(lineupB, prevLineupB)
      ? []
      : lineupB.map(id => playerMap.get(id)).filter(Boolean);

    prevLineupA = lineupA;
    prevLineupB = lineupB;

    result.push({
      minute: minute + 1,
      teamA_players,
      teamB_players
    });
  }

  res.status(200).json(JSend.success(result));
}));

// Funzione helper
function arraysEqual(a: number[], b: number[]): boolean {
  if (a.length !== b.length) return false;
  return a.every((val, i) => val === b[i]);
}

export default router;