<?php

namespace App\Form;

use App\Entity\Video;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\UrlType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints as Assert;



class VideoType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('title',TextType::class,[
                "label"=>"Titre",
            ])
            ->add('videoLink',UrlType::class,[
                "label"=>"Lien vidéo",
            ])
            ->add('description',TextareaType::class,[
                "label"=>"Description"
            ])
            ->add('premiumVideo', CheckboxType::class, [
                'attr' => [
                    'class' => 'form-check-input',
                
                ],
                'required' => false,
                'label' => '<span class="star">&#9733;</span> Vidéo réservée aux membres',
                'label_html' => true, 
                'label_attr' => [
                    'class' => 'form-check-label'
                ],

                'constraints' => [
                    new Assert\NotNull()
                ]
            ])
            
    
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Video::class,
        ]);
    }
}
