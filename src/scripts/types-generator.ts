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
        const className = convertSnakeCaseToPascalCase(tableName);
        console.log(tableName);

        // Import
        let classFileContent = '';
        classFileContent += `import { FormControl, Validators } from '@angular/forms';\n`;
        classFileContent += `import { DbUtils } from '../DbUtils';\n`;
        classFileContent += `import { Table } from '../Table';\n`;

        // Class opening
        classFileContent += `\n`;
        classFileContent += `export class ${className} implements Table {\n`;

        const infoSchemaColumns: any[] = await prisma.$queryRaw`
            SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, ORDINAL_POSITION
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_SCHEMA = 'lba' AND TABLE_NAME = ${tableName}
            ORDER BY ORDINAL_POSITION
        `;

        // Fields
        classFileContent += `\n`;
        for (const column of infoSchemaColumns) {
            classFileContent += `    ${column.COLUMN_NAME}: ${mapFieldTypeToTypeScript(column)} | undefined;\n`;
        }

        // Constructor
        classFileContent += `\n`;
        classFileContent += `    constructor(values?: any) {\n`;
        classFileContent += `        if (values) {\n`;
        for (const column of infoSchemaColumns) {
            classFileContent += `            this.${column.COLUMN_NAME} = values.${column.COLUMN_NAME};\n`;
        }
        classFileContent += `        }\n`;
        classFileContent += `    }\n`;

        // getName()
        classFileContent += `\n`;
        classFileContent += `    getName(): string {\n`;
        classFileContent += `        return '${tableName}';\n`;
        classFileContent += `    }\n`;

        // fromDbValues()
        classFileContent += `\n`;
        classFileContent += `    fromDbValues(values: any): ${className} {\n`;
        classFileContent += `        const new${className} = new ${className}();\n`;
        for (const column of infoSchemaColumns) {
            if (mapFieldTypeToTypeScript(column) === 'Date') {
                classFileContent += `        new${className}.${column.COLUMN_NAME} = DbUtils.epochToDate(values.${column.COLUMN_NAME});\n`;
            } else {
                classFileContent += `        new${className}.${column.COLUMN_NAME} = values.${column.COLUMN_NAME};\n`;
            }
        }
        classFileContent += `        return new${className};\n`;
        classFileContent += `    }\n`;

        // toDbValues()
        classFileContent += `\n`;
        classFileContent += `    toDbValues(): any {\n`;
        classFileContent += `        return {\n`;
        for (const column of infoSchemaColumns) {
            if (mapFieldTypeToTypeScript(column) === 'Date') {
                classFileContent += `            ${column.COLUMN_NAME}: DbUtils.dateToEpoch(this.${column.COLUMN_NAME}),\n`;
            } else {
                classFileContent += `            ${column.COLUMN_NAME}: this.${column.COLUMN_NAME},\n`;
            }
        }
        classFileContent += `        }\n`;
        classFileContent += `    }\n`;

        // toFormGroup()
        classFileContent += `\n`;
        classFileContent += `    toFormGroup(): any {\n`;
        classFileContent += `        return {\n`;
        for (const column of infoSchemaColumns) {
            if (column.COLUMN_NAME === 'id') {
                continue;
            }
            if (column.IS_NULLABLE === false) {
                classFileContent += `            ${column.COLUMN_NAME}: new FormControl(this.${column.COLUMN_NAME}, [Validators.required]),\n`;
            } else {
                classFileContent += `            ${column.COLUMN_NAME}: new FormControl(this.${column.COLUMN_NAME}),\n`;
            }
        }
        classFileContent += `        }\n`;
        classFileContent += `    }\n`;

        // End
        classFileContent += `\n`;
        classFileContent += '}\n';

        const filePath = path.join(outputFolder, `${className}.ts`);
        fs.writeFileSync(filePath, classFileContent);
    }

}

function convertSnakeCaseToPascalCase(input: string): string {
    return input.toLowerCase()
                .replace(/(_\w)/g, match => match[1].toUpperCase())
                .replace(/^\w/, match => match.toUpperCase());
}

function mapFieldTypeToTypeScript(column: any): string {
    switch (column.DATA_TYPE.toLowerCase()) {

        case 'int':
            return 'number';

        case 'bigint':
            return 'Date';

        case 'varchar':
        case 'text':
            return 'string';

        default:
            return 'any';

    }
}

const outputFolder = process.argv[2];
if (!outputFolder) {
    console.error('Usage: ts-node routes-generator.ts <output-folder>');
    process.exit(1);
}

generate(outputFolder)
    .catch((error) => {
        console.error('Error generating: ', error);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
