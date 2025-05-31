<?php

namespace App\Form;

use App\Entity\Product;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\File;
use Symfony\Contracts\Translation\TranslatorInterface;

class ProductType extends AbstractType
{
    public function __construct(private TranslatorInterface $translator)
    {
        
    }
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('name', null, [
                'label' => ucfirst($this->translator->trans('name')) . ":"
            ])
            ->add('description', null, [
                'label' => ucfirst($this->translator->trans('description')) . ":"
            ])
            ->add('price', null, [
                'label' => ucfirst($this->translator->trans('price')) . ":"
            ])
            ->add('image', FileType::class, [
                'label'     => ucfirst($this->translator->trans('upload image')) . ":",
                'mapped'    => false,
                'required'  => false,
                'constraints' => [
                    new File([
                        'maxSize' => '1024k',                        
                        'mimeTypesMessage' => 'Please upload a valid IMG',
                    ])
                ]
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Product::class,
        ]);
    }
}
