import {
  All,
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Req,
} from '@nestjs/common';
import { OdataService } from './odata.service';

@Controller('odata/v3')
export class OdataController {
  constructor(private readonly odataService: OdataService) {}

  @All('*')
  async OdataHandler(@Req() req: any) {
    const entity = req.entity;
    const id = req.id;
    const method = req.method;
   
    switch (method) {
      case 'GET':
        if (id) {
          return this.odataService.getOne(entity, id, req);
        } else {
          return this.odataService.getAll(entity, req);
        }
      case 'POST':
          return this.odataService.create(entity, req);
      case 'PUT':
        return this.odataService.update(entity, id, req);
      case 'DELETE':
        return this.odataService.delete(entity ,id , req);
      default:
        return 'Method not allowed!';
    }
  }
}
