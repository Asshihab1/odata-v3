import {
  Injectable,
  NotFoundException,
  BadRequestException,
  MethodNotAllowedException,
} from '@nestjs/common';
import { stat } from 'fs';
import { take } from 'rxjs';
import { serializeBigInt } from 'src/config/lib/BigIntPerser';
import { PrismaService } from 'src/config/services/prisma/prisma.service';
@Injectable()
export class OdataService {
  private prisma = new PrismaService();
  
  async getAll(entity: string, req?: any) {
    let host = req.get('host');
    let protocol = req.protocol;
    const model = this.prisma[entity.toLowerCase()];
    if (!model)
      throw new NotFoundException(
        `Entity ${entity} not found in ${req.method}`,
      );

    try {
      const data = await model.findMany(req.prismaQuery);
      return {
        '@odata.context': `${protocol}://${host}/odata/v3/$metadata#${entity}`,
        value: serializeBigInt(data) ?? [],
      };
    } catch (error) {
      throw new BadRequestException({
        message: `Failed to get record in '${entity}'`,
        error: error.message,
      });
    }
  }

  async getOne(entity: string, id: string, req?: any) {
    console.log(req.prismaQuery , 'from main')
    let host = req.get('host');
    let protocol = req.protocol;
    const model = this.prisma[entity.toLowerCase()];
    if (!model)
      throw new NotFoundException(
        `Entity ${entity} not found in ${req.method}`,
      );
    else if (!id)
      throw new BadRequestException(
        `Entity ${entity} not found in ${req.method}`,
      );

    try {
      const data = await model.findUnique(req.prismaQuery);

      return {
        '@odata.context': `${protocol}://${host}/odata/v3/$metadata#${entity}(${id})`,
        value: serializeBigInt(data) ?? [],
      };
    } catch (error) {
      throw new BadRequestException({
        message: `Failed to get record in '${entity}'`,
        error: error.message,
      });
    }
  }

  async create(entity: string, req: any) {
    let host = req.get('host');
    let protocol = req.protocol;
    const model = this.prisma[entity.toLowerCase()];
    if (!model) {
      throw new NotFoundException(`Entity ${entity} not found`);
    }

    if (req.id)
      throw new MethodNotAllowedException({
        error: `${entity}(${req.id}) not allowed in ${req.method}`,
        statusCode: 405,
      });

    try {
      const data = await model.create({
        data: req.body,
      });

      return {
        '@odata.context': `${protocol}://${host}/odata/v3/$metadata#${entity}`,
        value: serializeBigInt(data) ?? [],
      };
    } catch (error) {
      throw new BadRequestException({
        message: `Failed to create record in '${entity}'`,
        error: error.message,
      });
    }
  }

  async update(entity: string, id: string, req: any) {
    const model = this.prisma[entity.toLowerCase()];
    let host = req.get('host');
    let protocol = req.protocol;
    if (!model)
      throw new NotFoundException(
        `Entity ${entity} not found in ${req.method}`,
      );
    else if (!id)
      throw new BadRequestException(
        `Entity ${entity} not found in ${req.method}`,
      );

    try {
      const data = await model.update({
        where: { id: Number(id) },
        data: req.body,
      });

      return {
        '@odata.context': `${protocol}://${host}/odata/v3/$metadata#${entity}${`(${id})`}`,
        value: serializeBigInt(data) ?? [],
      };
    } catch (error) {
      if (error.meta?.cause) {
        throw new BadRequestException({ error: error.meta.cause });
      }
      throw new BadRequestException({ error: error.message });
    }
  }

  async delete(entity: string, id: string, req: any) {
    const model = this.prisma[entity.toLowerCase()];
    if (!model)
      throw new NotFoundException(
        `Entity ${entity} not found in ${req.method}`,
      );
    else if (!id)
      throw new BadRequestException(
        `Entity ${entity} not found in ${req.method}`,
      );
    try {
      const data = await model.delete({
        where: { id: Number(id) },
      });

      return {
        '@odata.context': `${req.protocol}://${req.get(
          'host',
        )}/odata/v3/$metadata#${entity}${`(${id})`}`,
        value: serializeBigInt(data) ?? [],
      };
    } catch (error) {
      if (error.meta?.cause) {
        throw new BadRequestException({ error: error.meta.cause });
      }
      throw new BadRequestException({ error: error.message });
    }
  }
}
