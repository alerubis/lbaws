import express from 'express';

// Auto
import cardRoutes from './auto/card-routes';
import cardSetttingsRoutes from './auto/card_settings-routes';
import dashboardCardSettingsRoutes from './auto/dashboard_card_settings-routes';
import v_player_year_league_summary_minute_game_routes from './auto/v_player_year_league_summary_minute_game-routes';
import v_player_year_league_summary_minute_quarter_routes from './auto/v_player_year_league_summary_minute_quarter-routes';
import v_player_year_league_summary_seconds_play_routes from './auto/v_player_year_league_summary_seconds_play-routes';
import v_player_year_league_summary_routes from './auto/v_player_year_league_summary-routes';
import v_team_year_league_summary_minutes_game_routes from './auto/v_team_year_league_summary_minutes_game-routes';
import v_team_year_league_summary_minutes_quarter_routes from './auto/v_team_year_league_summary_minutes_quarter-routes';
import v_team_year_league_summary_seconds_play_routes from './auto/v_team_year_league_summary_seconds_play-routes';
import v_team_year_league_summary_routes from './auto/v_team_year_league_summary-routes';

// Custom
import dashboardRoutes from './custom/dashboard-routes';
import dashboardCardRoutes from './custom/dashboard_card-routes';

const router = express.Router();

// Auto
router.use('/card', cardRoutes);
router.use('/card_settings', cardSetttingsRoutes);
router.use('/dashboard_card_settings', dashboardCardSettingsRoutes);

router.use('/v_player_year_league_summary_minute_game', v_player_year_league_summary_minute_game_routes);
router.use('/v_player_year_league_summary_minute_quarter', v_player_year_league_summary_minute_quarter_routes);
router.use('/v_player_year_league_summary_seconds_play', v_player_year_league_summary_seconds_play_routes);
router.use('/v_player_year_league_summary', v_player_year_league_summary_routes);
router.use('/v_team_year_league_summary_minutes_game', v_team_year_league_summary_minutes_game_routes);
router.use('/v_team_year_league_summary_minutes_quarter', v_team_year_league_summary_minutes_quarter_routes);
router.use('/v_team_year_league_summary_seconds_play', v_team_year_league_summary_seconds_play_routes);
router.use('/v_team_year_league_summary', v_team_year_league_summary_routes);

// Custom
router.use('/dashboard', dashboardRoutes);
router.use('/dashboard_card', dashboardCardRoutes);

export default router;
