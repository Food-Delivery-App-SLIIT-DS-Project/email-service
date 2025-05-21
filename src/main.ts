import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';
import { join } from 'path';
import { EMAIL_PACKAGE_NAME } from './types/email';

async function bootstrap() {
  const url = process.env.EMAIL_SERVICE_URL || '0.0.0.0:50058';
  const app = await NestFactory.createMicroservice<MicroserviceOptions>(AppModule, {
    transport: Transport.GRPC,
    options: {
      protoPath: join(__dirname, '../proto/email.proto'),
      url: url,
      package: [EMAIL_PACKAGE_NAME], // <- from your .proto
    },
  });
  app.enableShutdownHooks();
  await app.listen();
  console.log(`Email service is running on ${url}`);
}
bootstrap();
