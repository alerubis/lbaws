import { Player } from './../../../scripts/data-import';
import { dz_shot } from './../../../../node_modules/.prisma/client/index.d';
import { PrismaClient } from '@prisma/client';
import express from 'express';
import { wrapAsync } from '../../../shared/functions';
import { JSend } from '../../../shared/jsend';

const prisma = new PrismaClient();
const router = express.Router();

router.post('/first-lineup', wrapAsync(async (req: any, res: any) => {
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
    .slice(0, 1);

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
  //const result = [topLineups[0].minuti_giocati, topLineups[0].players[0], topLineups[0].players[1], topLineups[0].players[2], topLineups[0].players[3], topLineups[0].players[4]]
  //const result = allPlayers;
  const result = [topLineups[0].players[0], topLineups[0].players[1], topLineups[0].players[2], topLineups[0].players[3], topLineups[0].players[4]]

  res.status(200).json(JSend.success(result));
}));

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
      fouls_committedo: 0,
      fouls_received: 0,
      fouls_receivedo: 0,
      points: 0,
      pointso: 0,
      made_2pt: 0,
      made_2pto: 0,
      missed_2pt: 0,
      missed_2pto: 0,
      pct_2pt: 0,
      pct_2pto: 0,
      made_3pt: 0,
      made_3pto: 0,
      missed_3pt: 0,
      missed_3pto: 0,
      pct_3pt: 0,
      pct_3pto: 0,
      made_ft: 0,
      made_fto: 0,
      missed_ft: 0,
      missed_fto: 0,
      pct_ft: 0,
      pct_fto: 0,
      off_reb: 0,
      off_rebo: 0,
      def_reb: 0,
      def_rebo: 0,
      blocks_made: 0,
      blocks_madeo: 0,
      blocks_suffered: 0,
      blocks_sufferedo: 0,
      turnovers: 0,
      turnoverso: 0,
      steals: 0,
      stealso: 0,
      assists: 0,
      assistso: 0,
      minutes_played: lineup.minuti_giocati
    };

    for (const sp of matchingSubPlays) {
      const shot = dzShots.find(ds => ds.id === sp.shot_id);

      // Fouls
      if (sp.foul_id) {
        if (playerIds.includes(Number(sp.player_made_id))) {
          stats.fouls_committed++;
        }
        else if (sp.team_made_id !== team_id){
          stats.fouls_committedo++;
        }
        if (playerIds.includes(Number(sp.player_suffered_id))) {
          stats.fouls_received++;
        }
        else if (sp.team_made_id !== team_id){
          stats.fouls_receivedo++;
        }
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
      else if (shot && sp.team_made_id !== team_id) {
        if (shot.made_01 === '1') {
          stats.pointso += shot.point;

          if (shot.point === 2) stats.made_2pto++;
          else if (shot.point === 3) stats.made_3pto++;
          else if (shot.point === 1) stats.made_fto++;
        } else {
          if (shot.point === 2) stats.missed_2pto++;
          else if (shot.point === 3) stats.missed_3pto++;
          else if (shot.point === 1) stats.missed_fto++;
        }
      }

      // Rebounds
      if (sp.rebound_offensive_01 === '1' && playerIds.includes(Number(sp.player_made_id))) {
        stats.off_reb++;
      }
      if (sp.rebound_defensive_01 === '1' && playerIds.includes(Number(sp.player_made_id))) {
        stats.def_reb++;
      }

      if (sp.rebound_offensive_01 === '1' && sp.team_made_id !== team_id) {
        stats.off_rebo++;
      }
      if (sp.rebound_defensive_01 === '1' && sp.team_made_id !== team_id) {
        stats.def_rebo++;
      }

      // Blocks
      if (sp.blocks_01 === '1' && playerIds.includes(Number(sp.player_made_id))) {
        stats.blocks_made++;
      }
      if (sp.blocks_01 === '1' && playerIds.includes(Number(sp.player_suffered_id))) {
        stats.blocks_suffered++;
      }

      if (sp.blocks_01 === '1' && sp.team_made_id !== team_id) {
        stats.blocks_madeo++;
      }
      if (sp.blocks_01 === '1' && sp.team_suffered_id !== team_id) {
        stats.blocks_sufferedo++;
      }
      // Turnovers and steals
      if (sp.turnover_id && playerIds.includes(Number(sp.player_made_id))) {
        stats.turnovers++;
      }
      if (sp.turnover_id && playerIds.includes(Number(sp.player_suffered_id))) {
        stats.steals++;
      }

      if (sp.turnover_id && sp.team_made_id !== team_id) {
        stats.turnoverso++;
      }
      if (sp.turnover_id && sp.team_suffered_id !== team_id) {
        stats.stealso++;
      }

      // Assists
      if (sp.assist_01 === '1' && playerIds.includes(Number(sp.player_made_id))) {
        stats.assists++;
      }
      else if (sp.assist_01 === '1' && sp.team_made_id !== team_id) {
        stats.assistso++;
      }
    }

    // Calculate percentages
    const total2pt = stats.made_2pt + stats.missed_2pt;
    const total3pt = stats.made_3pt + stats.missed_3pt;
    const totalFt = stats.made_ft + stats.missed_ft;

    stats.pct_2pt = total2pt > 0 ? Math.round((stats.made_2pt * 100) / total2pt * 10) / 10 : 0;
    stats.pct_3pt = total3pt > 0 ? Math.round((stats.made_3pt * 100) / total3pt * 10) / 10 : 0;
    stats.pct_ft = totalFt > 0 ? Math.round((stats.made_ft * 100) / totalFt * 10) / 10 : 0;

    const total2pto = stats.made_2pto + stats.missed_2pto;
    const total3pto = stats.made_3pto + stats.missed_3pto;
    const totalFto = stats.made_fto + stats.missed_fto;

    stats.pct_2pto = total2pto > 0 ? Math.round((stats.made_2pto * 100) / total2pto * 10) / 10 : 0;
    stats.pct_3pto = total3pto > 0 ? Math.round((stats.made_3pto * 100) / total3pto * 10) / 10 : 0;
    stats.pct_fto = totalFto > 0 ? Math.round((stats.made_fto * 100) / totalFto * 10) / 10 : 0;

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
    //const windowA = teamsMap[teamA_id]?.find(w => second >= w.seconds_start && second <= w.seconds_end);
    //const windowB = teamsMap[teamB_id]?.find(w => second >= w.seconds_start && second <= w.seconds_end);
    let windowA = teamsMap[teamA_id]?.find(w => second >= w.seconds_start && second <= w.seconds_end);
    if (!windowA && teamsMap[teamA_id]) {
      windowA = teamsMap[teamA_id]
        .filter(w => w.seconds_end < second)
        .sort((a, b) => b.seconds_end - a.seconds_end)[0];
    }
    let windowB = teamsMap[teamB_id]?.find(w => second >= w.seconds_start && second <= w.seconds_end);
    if (!windowB && teamsMap[teamB_id]) {
      windowB = teamsMap[teamB_id]
        .filter(w => w.seconds_end < second)
        .sort((a, b) => b.seconds_end - a.seconds_end)[0];
    }
    
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