import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { OdataModule } from './odata/odata.module';

@Module({
  imports: [OdataModule],  
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
