import { PrismaClient } from '@prisma/client';
import * as fs from 'fs';
import * as path from 'path';

const prisma = new PrismaClient();

async function generate(outputFolder: string) {

    const infoSchemaTables: any[] = await prisma.$queryRaw`
        SELECT TABLE_NAME
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_SCHEMA = 'lba'
    `;

    for (const table of infoSchemaTables) {
        const tableName = table.TABLE_NAME;
        console.log(tableName);

        // Import
        let classFileContent = '';
        classFileContent += `import { PrismaClient } from '@prisma/client';\n`;
        classFileContent += `import express from 'express';\n`;
        classFileContent += `import { authenticateToken } from '../../../shared/auth';\n`;
        classFileContent += `import { wrapAsync } from '../../../shared/functions';\n`;
        classFileContent += `import { JSend } from '../../../shared/jsend';\n`;

        // Router setup
        classFileContent += `\nconst prisma = new PrismaClient();\n`;
        classFileContent += `\nconst router = express.Router();`;
        classFileContent += `\nrouter.use(authenticateToken());\n`;

        // Read route
        classFileContent += `\nrouter.post('/read', wrapAsync(async (req: any, res: any) => {\n`;
        classFileContent += `    const response = await prisma.$transaction(async (tx) => {\n`;
        classFileContent += `        const rows = await tx.${tableName}.findMany({\n`;
        classFileContent += `            skip: req.body?.skip,\n`;
        classFileContent += `            take: req.body?.take || 1,\n`;
        classFileContent += `            where: req.body?.where,\n`;
        classFileContent += `            orderBy: req.body?.orderBy,\n`;
        classFileContent += `        });\n`;
        classFileContent += `        const count = await tx.${tableName}.count({ where: req.body?.where });\n`;
        classFileContent += `        return {\n`;
        classFileContent += `            rows: rows,\n`;
        classFileContent += `            count: count,\n`;
        classFileContent += `        };\n`;
        classFileContent += `    },{timeout: 15000});\n`;
        classFileContent += `    res.status(200).json(JSend.success(response));\n`;
        classFileContent += `}));\n`;

        // Export router
        classFileContent += `\nexport default router;\n`;

        const filePath = path.join(outputFolder, `${tableName}-routes.ts`);
        fs.writeFileSync(filePath, classFileContent);
    }
}

const outputFolder = process.argv[2];
if (!outputFolder) {
    console.error('Usage: ts-node types-generator.ts <output-folder>');
    process.exit(1);
}

generate(outputFolder)
    .catch((error) => {
        console.error('Error generating: ', error);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
