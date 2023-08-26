<?php

namespace App\Entity;


use App\Repository\VideoRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use Symfony\Component\Validator\Constraints\NotBlank;
use App\Entity\Traits\Timestampable;


#[ORM\Entity(repositoryClass: VideoRepository::class)]
#[ORM\Table(name: "videos")]
#[ORM\HasLifecycleCallbacks]


class Video
{

    use Timestampable;
    
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 50)]
    #[Assert\NotBlank(message : "Veuillez entrer un titre")]
    #[Assert\Length(min: 3, minMessage: "Veuillez entrer un titre de minimum 3 caractères")]
    #[Assert\NotEqualTo(value: "merde", message: "Vous ne pouvez pas introduire le mot grossier (m****)")]
    private ?string $title = null;

    

    #[ORM\Column(length: 500)]
    #[Assert\NotBlank(message:"Le champ ne peut être vide")]
    private ?string $videoLink = null;

    #[ORM\Column(type: Types::TEXT)]
    #[Assert\NotBlank(message : "Veuillez entrer une description")]
    #[Assert\Length(min: 20, minMessage: "Veuillez entrer une description de minimum 20 caractères")]
    #[Assert\NotEqualTo(value: "wesh", message: "Vous ne pouvez pas introduire le mot grossier (w***)")]
    private ?string $description = null;

    #[ORM\ManyToOne(inversedBy: 'videos')]
    #[ORM\JoinColumn(nullable: false)]
    private ?User $user = null;

    #[ORM\Column]
    private ?bool $premiumVideo = null;



    /*#[ORM\Column(type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $createdAt = null;

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $updatedAt = null;*/

   
    

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }

    public function setTitle(?string $title): static
    {
        $this->title = $title;

        return $this;
    }

    public function getVideoLink(): ?string
    {
        return $this->videoLink;
    }

    public function setVideoLink(?string $videoLink): static
    {
        $this->videoLink = $videoLink;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(?string $description): static
    {
        $this->description = $description;

        return $this;
    }

    
     
/*public function getCreatedAt(): ?\DateTimeImmutable
    {
        return $this->createdAt;
    }

    public function setCreatedAt(\DateTimeImmutable $createdAt): self
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    public function getUpdatedAt(): ?\DateTimeImmutable
    {
        return $this->updatedAt;
    }

    public function setUpdatedAt(\DateTimeImmutable $updateAt): self
    {
        $this->updatedAt = $updateAt;

        return $this;
    }*/

public function getUser(): ?User
{
    return $this->user;
}

public function setUser(?User $user): static
{
    $this->user = $user;

    return $this;
}

public function isPremiumVideo(): ?bool
{
    return $this->premiumVideo;
}

public function setPremiumVideo(bool $premiumVideo): static
{
    $this->premiumVideo = $premiumVideo;

    return $this;
}
   
}
   

