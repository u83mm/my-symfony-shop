<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20220925092355 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP INDEX IDX_F5299398A76ED395 ON `order`');
        $this->addSql('ALTER TABLE `order` ADD order_content_id INT NOT NULL, DROP total_price, DROP price');
        $this->addSql('ALTER TABLE order_content ADD name VARCHAR(50) NOT NULL, ADD description LONGTEXT NOT NULL');
        $this->addSql('DROP INDEX IDX_D34A04ADCFFE9AD6 ON product');
        $this->addSql('ALTER TABLE product DROP orders_id');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE `order` ADD total_price NUMERIC(10, 2) NOT NULL, ADD price NUMERIC(10, 2) NOT NULL, DROP order_content_id');
        $this->addSql('CREATE INDEX IDX_F5299398A76ED395 ON `order` (user_id)');
        $this->addSql('ALTER TABLE product ADD orders_id INT DEFAULT NULL');
        $this->addSql('CREATE INDEX IDX_D34A04ADCFFE9AD6 ON product (orders_id)');
        $this->addSql('ALTER TABLE order_content DROP name, DROP description');
    }
}
