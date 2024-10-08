<?php

namespace App\Controller;

use App\Repository\PostRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class PageController extends AbstractController
{
    #[Route('/', name: 'app_page')]
    public function index(): Response
    {
        return $this->render('page/index.html.twig');
    }

    #[Route('/p/{slug}', name: 'app_post_show')]
    public function show(PostRepository $pr, string $slug): Response
    {
        return $this->render('page/show.html.twig', [
            'post' => $pr->findOneBy(['slug' => $slug]),
        ]);
    }
}