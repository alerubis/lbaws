import express from 'express';

// Auto
import cardTypeRoutes from './auto/card_type-routes';
import cardRoutes from './auto/card-routes';

// Custom
import dashboardRoutes from './custom/dashboard-routes';
import dashboardCardRoutes from './custom/dashboard_card-routes';

const router = express.Router();

// Auto
router.use('/card_type', cardTypeRoutes);
router.use('/card', cardRoutes);

// Custom
router.use('/dashboard', dashboardRoutes);
router.use('/dashboard_card', dashboardCardRoutes);

export default router;
