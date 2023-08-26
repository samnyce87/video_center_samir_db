<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

use App\Form\UserFormType;
use Symfony\Component\HttpFoundation\Request;
use Doctrine\ORM\EntityManagerInterface;

class AccountController extends AbstractController
{
    #[Route('/account', name: 'app_account')]

    public function show(): Response
    {
        
        if (!$this->getUser()){
            
            $this->addFlash('error', 'Vous devez vous connecter par email pour voir votre profil!');
            return $this->redirectToRoute('app_login');
        } 

        return $this->render('account/show.html.twig');

    }
    #[Route('/account/edit', name: 'app_account_edit')]

    public function edit(Request $request, EntityManagerInterface $em): Response
    {

    
        if (!$this->getUser()){
            
            $this->addFlash('error', 'Votre compte non modifié!');
            return $this->redirectToRoute('app_login');
        } 
    
    

        $user = $this->getUser();
        $form = $this->createForm(UserFormType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em->flush();
            $this->addFlash('success', 'Compte mise à jour avec succès !');
            return $this->redirectToRoute('app_account');
        }
        return $this->render('account/edit.html.twig', [
            'user' => $user,
            'userForm' => $form->createView()
        ]);
    }
}

