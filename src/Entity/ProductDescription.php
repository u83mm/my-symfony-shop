<?php

namespace App\Entity;

use App\Repository\ProductDescriptionRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ProductDescriptionRepository::class)]
class ProductDescription
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $esDescription = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $enDescription = null;

    /**
     * @var Collection<int, Product>
     */
    #[ORM\OneToMany(mappedBy: 'productDescription', targetEntity: Product::class, orphanRemoval: true)]
    private Collection $product;

    public function __construct()
    {
        $this->product = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getEsDescription(): ?string
    {
        return $this->esDescription;
    }

    public function setEsDescription(?string $esDescription): static
    {
        $this->esDescription = $esDescription;

        return $this;
    }

    public function getEnDescription(): ?string
    {
        return $this->enDescription;
    }

    public function setEnDescription(?string $enDescription): static
    {
        $this->enDescription = $enDescription;

        return $this;
    }

    /**
     * @return Collection<int, Product>
     */
    public function getProduct(): Collection
    {
        return $this->product;
    }

    public function addProduct(Product $product): static
    {
        if (!$this->product->contains($product)) {
            $this->product->add($product);
            $product->setProductDescription($this);
        }

        return $this;
    }

    public function removeProduct(Product $product): static
    {
        if ($this->product->removeElement($product)) {
            // set the owning side to null (unless already changed)
            if ($product->getProductDescription() === $this) {
                $product->setProductDescription(null);
            }
        }

        return $this;
    }
}
