<?php

namespace App\Controller;

use App\Entity\Video;
use App\Repository\VideoRepository;
use App\Form\VideoType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;





use App\Form\SearchType;
use App\Model\SearchData;

use Symfony\Component\HttpFoundation\Request;
use Doctrine\ORM\EntityManagerInterface;


use Knp\Component\Pager\PaginatorInterface;


class VideoController extends AbstractController

{
    #[Route('/', name: 'app_home',methods: ['GET'])]
    public function index(VideoRepository $videoRepository,PaginatorInterface $paginator ,Request $request,): Response

{

  if ($this->getUser()){
    if (!$this->getUser()->isVerified()){
        $this->addFlash('info', 'aucune vérification de votre email');
    }  
}


$pagination = $paginator->paginate(
    $videoRepository->paginationQuery(),
    $request->query->get('page', 1),
    9


);


$search = false;



//barre de recherche
$searchData = new SearchData();
$form = $this->createForm(SearchType::class, $searchData);
$form->handleRequest($request);
if ($form->isSubmitted() && $form->isValid()) {
// dd($searchData->query);
$searchData->page = $request->query->getInt('page', 1);
// $videos = $repo->findBySearch($searchData);
$pagination = $paginator->paginate(
    $videoRepository->findBySearch($searchData),
    $request->query->get('page', 1),
    9
);
$search = true;

$nombreVideos = $pagination->getTotalItemCount();

return $this->render('video/index.html.twig', [
    'form' => $form,
    'pagination' => $pagination,
    'search' => $search,
    'searchData' => $searchData->query,
    'videos' => $videoRepository->findBySearch($searchData),
    "nombreVideos" => $nombreVideos
]);
}

return $this->render('video/index.html.twig', [
'form' => $form->createView(),
'pagination' => $pagination,
'search' => $search,
// 'videos' => $videoRepository->findAll()
]);

    }


     

#[Route('/video/{id<[0-9]+>}', name: 'app_video_show', methods: ['GET'])]


 public function show(Video $video): Response
{

    if ($this->getUser()) {
        if ($this->getUser()->isVerified() == false && $video->isPremiumVideo()) {
            $this->addFlash('error', 'Vous devez confirmer votre email pour avoir accés aux vidéo premium!');
            return $this->redirectToRoute('app_login');
        }
    } else {
        $this->addFlash('error', 'vous devez vous enregistrer pour avoir accés aux vidéo premium!');
        return $this->redirectToRoute('app_register');
    }
    return $this->render('video/show.html.twig', compact('video'));
       

}

   #[Route('/video/create', name:'app_video_create', methods: ['GET', 'POST'])]

   public function create(Request $request, EntityManagerInterface $em): Response
 {

  if ($this->getUser()){
    if ($this->getUser()->isVerified() == false) {
        $this->addFlash('error', 'Vous devez confirmer votre email pour créer une video!');
        return $this->redirectToRoute('app_home');
    } 
}else{
    $this->addFlash('error', 'vous devez vous connecter pour céer une video!');
    return $this->redirectToRoute('app_login');
}

 $video = new Video;
 $form = $this->createForm(VideoType::class, $video);
 $form->handleRequest($request);
 if ($form->isSubmitted() && $form->isValid()) {
$video->setUser($this->getUser());
// $video->setPremiumVideo($form->get('premiumVideo')->getData());
 $em->persist($video);
 $em->flush();
 $this->addFlash('success', 'Video créer avec succès!');

 return $this->redirectToRoute('app_home');
 }

 return $this->render('video/create.html.twig', ['form' => $form->createView()]);


 }

 #[Route('/video/{id<[0-9]+>}/edit', name:'app_video_edit', methods: ['GET', 'POST'])]

 public function edit(Request $request, Video $video, EntityManagerInterface $em): Response
 {

  if ($this->getUser()) {
    if ($this->getUser()->isVerified() == false) {
        $this->addFlash('error', 'vous devez confirmer votre email pour modifier une video!');
        return $this->redirectToRoute('app_home');
    } else if ($video->getUser()->getEmail() !== $this->getUser()->getEmail()) {
        $this->addFlash('error', 'vous devez être lutilisateur ' . $video->getUser()->getFirstname() . ' pour editer une video!');
        return $this->redirectToRoute('app_home');
    }
} else {
    $this->addFlash('error', 'vous devez vous connecter pour editer une vidéo!');
    return $this->redirectToRoute('app_login');
}
 $form = $this->createForm(VideoType::class, $video);
 $form->handleRequest($request);
 
 if ($form->isSubmitted() && $form->isValid()) {
// $video->setPremiumVideo($form->get('premiumVideo')->getData());
 $em->flush();
 $this->addFlash('success', 'Video modifié avec succès!');
 return $this->redirectToRoute('app_home');
 }
 return $this->render('video/edit.html.twig', [
 'video' => $video,
 'form' => $form->createView()
 ]);
}

#[Route('/video/{id<[0-9]+>}', name:'app_video_delete')]

public function delete(Request $request, Video $video, EntityManagerInterface $em): Response
 {

  if ($this->getUser()) {
    if ($this->getUser()->isVerified() == false) {
        $this->addFlash('error', 'vous devez confirmer votre email pour supprimer une video!');
        return $this->redirectToRoute('app_home');
    } else if ($video->getUser()->getEmail() !== $this->getUser()->getEmail()) {
        $this->addFlash('error', 'Vous devez être lutilisateur ' . $video->getUser()->getFirstname() . ' pour supprimer une vidéo!');
        return $this->redirectToRoute('app_home');
    }
} else {
    $this->addFlash('error', 'vous devez vous connecter pour supprimer une video!');
    return $this->redirectToRoute('app_login');
}
if ($this->isCsrfTokenValid('delete' . $video->getId(), $request->request->get('_token'))) {
 $em->remove($video);
 $em->flush();
 $this->addFlash('success', 'Video supprimer avec succès!');
}
 return $this->redirectToRoute('app_home');
 

}

    
 }
