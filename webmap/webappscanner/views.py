from django.shortcuts import redirect
from django.shortcuts import render, get_object_or_404
from django.utils import timezone
from .forms import ScanUrl
from .models import Url
from . import webspiderman


def url_list(request):
    urls = Url.objects.filter(created_date__lte=timezone.now()).order_by('created_date')
    return render(request, 'exploit/url_list.html', {'urls': urls})


def url_detail(request, pk):
    url = get_object_or_404(Url, pk=pk)
    return render(request, 'exploit/url_detail.html', {'url': url})


def url_new(request):
    if request.method == "POST":
        form = ScanUrl(request.POST)
        if form.is_valid():
            url = form.save(commit=False)
            url.author = request.user
            url.created_date = timezone.now()
            url.save()
            return redirect('url_detail', pk=url.pk)
    else:
        form = ScanUrl()
    return render(request, 'exploit/url_edit.html', {'form': form})


def url_edit(request, pk):
    url = get_object_or_404(Url, pk=pk)
    if request.method == "POST":
        form = ScanUrl(request.POST, instance=url)
        if form.is_valid():
            url = form.save(commit=False)
            url.author = request.user
            url.created_date = timezone.now()
            url.save()
            return redirect('url_detail', pk=url.pk)
    else:
        form = ScanUrl(instance=url)
    return render(request, 'exploit/url_edit.html', {'form': form})


def url_rescan(request, pk):
    url = get_object_or_404(Url, pk=pk)
    urls = Url.objects.filter(created_date__lte=timezone.now()).order_by('created_date')
    return render(request, 'exploit/url_list.html', {'urls': urls})


def url_result(request, pk):
    url = get_object_or_404(Url, pk=pk)
    return render(request, 'results/%s.html' % url.keyid, {'url': url})


def url_download(request, pk):
    url = get_object_or_404(Url, pk=pk)
    return render(request, 'results/%s.html' % url.keyid, {'url': url})


def url_exploit(request, pk):
    url = get_object_or_404(Url, pk=pk)
    urls = Url.objects.filter(created_date__lte=timezone.now()).order_by('created_date')
    return render(request, 'exploit/url_list.html', {'urls': urls})


def url_exploit(request, pk):
    url = get_object_or_404(Url, pk=pk)
    bloodtrail.rescan(pk)
    urls = Url.objects.filter(created_date__lte=timezone.now()).order_by('created_date')
    return render(request, 'exploit/url_list.html', {'urls': urls})
