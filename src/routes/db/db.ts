import express from 'express';

// Auto
import cardRoutes from './auto/card-routes';
import cardTypeRoutes from './auto/card_type-routes';
import cardSetttingsRoutes from './auto/card_settings-routes';
import dashboardCardSettingsRoutes from './auto/dashboard_card_settings-routes';
import gameRoutes from './auto/game-routes';
import league_yearRoutes from './auto/league_year-routes';
import leagueRoutes from './auto/league-routes';
import refereeRoutes from './auto/referee-routes';
import typeGameRoutes from './auto/type_game-routes';
import typeLeagueTypeGameRoutes from './auto/type_league_type_game-routes';
import teamRoutes from './auto/team-routes';
import v_player_game_minute_boxscore_base from './auto/v_player_game_minute_boxscore_base-routes';
import v_player_game_minute_boxscore from './auto/v_player_game_minute_boxscore-routes';
import v_player_game_absolute_minute_boxscore from './auto/v_player_game_absolute_minute_boxscore-routes';
import v_player_game_total_boxscore from './auto/v_player_game_total_boxscore-routes';
import v_player_season_avg_boxscore from './auto/v_player_season_avg_boxscore-routes';
import v_player_season_game_type_avg_boxscore from './auto/v_player_season_game_type_avg_boxscore-routes';

// Custom
import dashboardRoutes from './custom/dashboard-routes';
import dashboardCardRoutes from './custom/dashboard_card-routes';
import playerRoutes from './auto/player-routes';

const router = express.Router();

// Auto
router.use('/card', cardRoutes);
router.use('/card_type', cardTypeRoutes);
router.use('/card_settings', cardSetttingsRoutes);
router.use('/card', cardRoutes);
router.use('/dashboard_card_settings', dashboardCardSettingsRoutes);
router.use('/game', gameRoutes);
router.use('/league_year', league_yearRoutes);
router.use('/league', leagueRoutes);
router.use('/referee', refereeRoutes);
router.use('/team', teamRoutes);
router.use('/player', playerRoutes);
router.use('/type_game', typeGameRoutes);
router.use('/type_league_type_game', typeLeagueTypeGameRoutes);

router.use('/v_player_game_minute_boxscore_base', v_player_game_minute_boxscore_base);
router.use('/v_player_game_minute_boxscore', v_player_game_minute_boxscore);
router.use('/v_player_game_absolute_minute_boxscore', v_player_game_absolute_minute_boxscore);
router.use('/v_player_game_total_boxscore', v_player_game_total_boxscore);
router.use('/v_player_season_avg_boxscore', v_player_season_avg_boxscore);
router.use('/v_player_season_game_type_avg_boxscore', v_player_season_game_type_avg_boxscore);

// Custom
router.use('/dashboard', dashboardRoutes);
router.use('/dashboard_card', dashboardCardRoutes);

export default router;
