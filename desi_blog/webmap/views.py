from django.contrib import messages
from django.http import HttpResponse, Http404
from django.shortcuts import render, get_object_or_404, redirect
from django.utils import timezone
from .models import Post
from .forms import PostForm, SearchForm
from django.contrib.auth.decorators import login_required
from django.views.decorators.cache import never_cache
from django.views.decorators.clickjacking import *



@xframe_options_deny
@never_cache
def post_list(request):
    posts = Post.objects.filter(published_date__lte=timezone.now()).order_by('-created_date')
    return render(request, 'post_list.html', {'posts': posts})


@xframe_options_deny
@never_cache
def post_detail(request, pk):
    try:
        post = get_object_or_404(Post, pk=pk)
    except:
        raise Http404

    return render(request, 'post_detail.html', {'post': post})


@xframe_options_deny
@never_cache
@login_required  # (login_url='/login/')
def post_new(request):
    if request.method == "POST":
        form = PostForm(request.POST, request.FILES or None)
        if form.is_valid() and request.user.is_authenticated():
            post = form.save(commit=False)
            post.author = request.user
            post.published_date = timezone.now()
            post.save()
            return redirect('post_detail', pk=post.pk)
    else:
        form = PostForm()
    return render(request, 'post_edit.html', {'form': form})


@xframe_options_deny
@never_cache
@login_required  # (login_url='/login/')
def post_edit(request, pk):
    try:
        post = get_object_or_404(Post, pk=pk)
    except:
        raise Http404

    if post.author != request.user:
        response = HttpResponse("You do not have permission to edit this Post")
        response.status_code = 403
        return response

    if request.method == "POST":
        form = PostForm(request.POST, request.FILES or None, instance=post)
        if form.is_valid() and request.user.is_authenticated():
            post = form.save(commit=False)
            post.author = request.user
            post.published_date = timezone.now()
            post.save()
            return redirect('post_detail', pk=post.pk)
    else:
        form = PostForm(instance=post)
    return render(request, 'post_edit.html', {'form': form})


@xframe_options_deny
@never_cache
@login_required  # (login_url='/login/')
def post_delete(request, pk):

    try:
        post = get_object_or_404(Post, pk=pk)
    except:
        raise Http404

    if request.method == "POST":
        if post.author != request.user:
            response = HttpResponse("You do not have permission to edit this Post")
            response.status_code = 403
            return response

        if request.user.is_authenticated():
            Post.objects.filter(id=post.pk).delete()
            messages.info(request, "The Post has been deleted")
        return redirect("/")

    return render(request, 'confirm_post_delete.html',{'post': post})


@xframe_options_deny
@never_cache
def search(request):
    form = SearchForm(request.POST or None)
    if request.method == 'POST':
        if form.is_valid():
            query = request.POST.get('search')
            if query:
                posts = Post.objects.filter(title__icontains=query)
                return render(request, 'post_list.html', {'posts': posts})
            else:
                return redirect("/")

    return redirect("/")
