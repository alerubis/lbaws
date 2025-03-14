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
        const card = await tx.card.findUnique({ where: { card_id: req.body.card_id } });
        const maxDashboardCard = await tx.dashboard_card.findFirst({
            where: { dashboard_id: req.body.dashboard_id },
            orderBy: { dashboard_card_id: 'desc' }
        });
        const data = {
            ...req.body,
            title: card?.description,
            dashboard_card_id: (maxDashboardCard?.dashboard_card_id || 0) + 1,
        };
        const dashboardCard = await tx.dashboard_card.create({ data: data });
        const cardSettings = await tx.card_settings.findMany({ where: { card_id: dashboardCard.card_id } });
        for (const cardSetting of cardSettings) {
            await tx.dashboard_card_settings.create({
                data: {
                    dashboard_id: dashboardCard.dashboard_id,
                    dashboard_card_id: dashboardCard.dashboard_card_id,
                    card_id: dashboardCard.card_id,
                    setting_id: cardSetting.setting_id,
                    value: cardSetting.default_value as any,
                },
            });
        }
        return dashboardCard;
    });
    res.status(200).json(JSend.success(response));
}));

router.post('/read', wrapAsync(async (req: any, res: any) => {
    const response = await prisma.$transaction(async (tx) => {
        const where = {
            ...req.body?.where,
        }
        const rows = await tx.dashboard_card.findMany({
            skip: req.body?.skip,
            take: req.body?.take || 1,
            where: where,
            orderBy: req.body?.orderBy,
        });
        const count = await tx.dashboard_card.count({ where: req.body?.where });
        return {
            rows: rows,
            count: count,
        };
    });
    res.status(200).json(JSend.success(response));
}));

router.post('/update', wrapAsync(async (req: any, res: any) => {
    const response = await prisma.$transaction(async (tx) => {
        const keys = {
            dashboard_id: req.body.dashboard_id,
            dashboard_card_id: req.body.dashboard_card_id,
        };
        const dashboardCard = await tx.dashboard_card.update({ where: { dashboard_id_dashboard_card_id: keys }, data: { title: req.body.title } });
        const dashboardCardSettings = req.body.dashboard_card_settings;
        if (dashboardCardSettings) {
            for (const setting of dashboardCardSettings) {
                if (setting.setting_id) {
                    await tx.dashboard_card_settings.update({
                        where: {
                            dashboard_id_dashboard_card_id_card_id_setting_id: {
                                dashboard_id: dashboardCard.dashboard_id,
                                dashboard_card_id: dashboardCard.dashboard_card_id,
                                card_id: dashboardCard.card_id,
                                setting_id: setting.setting_id,
                            }
                        },
                        data: {
                            value: setting.value,
                        },
                    });
                }
            }
        }
        return dashboardCard;
    });
    res.status(200).json(JSend.success(response));
}));

router.post('/delete', wrapAsync(async (req: any, res: any) => {
    const response = await prisma.$transaction(async (tx) => {
        const keys = {
            dashboard_id: req.body.dashboard_id,
            dashboard_card_id: req.body.dashboard_card_id,
        };
        await tx.dashboard_card_settings.deleteMany({ where: keys });
        const deletedRow = await tx.dashboard_card.delete({ where: { dashboard_id_dashboard_card_id: keys } });
        return deletedRow;
    });
    res.status(200).json(JSend.success(response));
}));

export default router;
