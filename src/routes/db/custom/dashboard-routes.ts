import { PrismaClient } from '@prisma/client';
import express from 'express';
import { authenticateToken } from '../../../shared/auth';
import { wrapAsync } from '../../../shared/functions';
import { JSend } from '../../../shared/jsend';

const prisma = new PrismaClient();

const router = express.Router();
router.use(authenticateToken());

router.post('/create', wrapAsync(async (req: any, res: any) => {
    const response = await prisma.$transaction(async (tx) => {
        const dashboard = await tx.dashboard.create({
            data: {
                description: req.body.description,
                team_id: req.user.team_id,
            }
        });
        return dashboard;
    });
    res.status(200).json(JSend.success(response));
}));

router.post('/read', wrapAsync(async (req: any, res: any) => {
    const response = await prisma.$transaction(async (tx) => {
        const where = {
            ...req.body?.where,
            team_id: req.user.team_id,
        }
        const rows = await tx.dashboard.findMany({
            skip: req.body?.skip,
            take: req.body?.take || 1,
            where: where,
            orderBy: req.body?.orderBy,
        });
        const count = await tx.dashboard.count({ where: req.body?.where });
        return {
            rows: rows,
            count: count,
        };
    });
    res.status(200).json(JSend.success(response));
}));

router.post('/update', wrapAsync(async (req: any, res: any) => {
    const response = await prisma.$transaction(async (tx) => {
        const updatedRow = await tx.dashboard.update({
            where: {
                dashboard_id: req.body.dashboard_id,
                team_id: req.user.team_id
            },
            data: {
                ...req.body,
                team_id: req.user.team_id,
            }
        });
        return updatedRow;
    });
    res.status(200).json(JSend.success(response));
}));

router.post('/delete', wrapAsync(async (req: any, res: any) => {
    const response = await prisma.$transaction(async (tx) => {
        await tx.dashboard_card_settings.deleteMany({ where: { dashboard_id: req.body.dashboard_id } });
        await tx.dashboard_card.deleteMany({ where: { dashboard_id: req.body.dashboard_id } });
        const deletedRow = await tx.dashboard.delete({ where: { dashboard_id: req.body.dashboard_id, team_id: req.user.team_id } });
        return deletedRow;
    });
    res.status(200).json(JSend.success(response));
}));

export default router;
