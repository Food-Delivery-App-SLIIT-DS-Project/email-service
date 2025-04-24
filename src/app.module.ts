import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true, // makes it available in all modules
    }),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
