import { PrismaClient } from '@prisma/client';
import express from 'express';
import { authenticateToken } from '../../../shared/auth';
import { wrapAsync } from '../../../shared/functions';
import { JSend } from '../../../shared/jsend';

const prisma = new PrismaClient();

const router = express.Router();
router.use(authenticateToken());

router.post('/read', wrapAsync(async (req: any, res: any) => {
    const response = await prisma.$transaction(async (tx) => {
        const rows = await tx.v_player_year_league_summary_minute_quarter.findMany({
            skip: req.body?.skip,
            take: req.body?.take || 1,
            where: req.body?.where,
            orderBy: req.body?.orderBy,
        });
        const count = await tx.v_player_year_league_summary_minute_quarter.count({ where: req.body?.where });
        return {
            rows: rows,
            count: count,
        };
    });
    res.status(200).json(JSend.success(response));
}));

export default router;
