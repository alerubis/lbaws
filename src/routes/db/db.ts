import express from 'express';

import dashboardRoutes from './custom/dashboard-routes';

const router = express.Router();

// Auto

// Custom
router.use('/dashboard', dashboardRoutes);

export default router;
