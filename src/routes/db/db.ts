import express from 'express';

// Auto
import cardRoutes from './auto/card-routes';
import cardSetttingsRoutes from './auto/card_settings-routes';
import dashboardCardSettingsRoutes from './auto/dashboard_card_settings-routes';

// Custom
import dashboardRoutes from './custom/dashboard-routes';
import dashboardCardRoutes from './custom/dashboard_card-routes';

const router = express.Router();

// Auto
router.use('/card', cardRoutes);
router.use('/card_settings', cardSetttingsRoutes);
router.use('/dashboard_card_settings', dashboardCardSettingsRoutes);

// Custom
router.use('/dashboard', dashboardRoutes);
router.use('/dashboard_card', dashboardCardRoutes);

export default router;
