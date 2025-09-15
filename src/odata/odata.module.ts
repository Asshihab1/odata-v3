import {
  Module,
  NestModule,
  MiddlewareConsumer,
  RequestMethod,
} from '@nestjs/common';
import { OdataController } from './odata.controller';
import { OdataService } from './odata.service';
import { QueryBuilder } from '../middleware/QueryBuilder';

@Module({
  controllers: [OdataController],
  providers: [OdataService],
})
export class OdataModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(QueryBuilder)
      .forRoutes({ path: 'odata/v3/*', method: RequestMethod.ALL });
  }
}
