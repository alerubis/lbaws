import express from 'express';
import { authenticateToken } from '../shared/auth';
import { wrapAsync } from '../shared/functions';
import { JSend } from '../shared/jsend';
import { PrismaClient } from '@prisma/client';

const router = express.Router();

const prisma = new PrismaClient();

router.use(authenticateToken());

router.post('/test', wrapAsync(async (req: any, res: any) => {
    res.status(200).json(JSend.success('Can see this!'));
}));

router.post('/dashboard-list', wrapAsync(async (req: any, res: any) => {
    const response = await prisma.dashboard.findMany({ where: { user_id: req.user.id } });
    res.status(200).json(JSend.success(response));
}));

export default router;
