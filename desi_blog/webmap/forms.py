from .models import Post
from django import forms
from tinymce import TinyMCE


class TinyMCEWidget(TinyMCE):
    def use_required_attribute(self, *args):
        return False


class PostForm(forms.ModelForm):
    title = forms.CharField(label="Title", widget=forms.TextInput())
    description = forms.CharField(widget=TinyMCEWidget(attrs={'required': False, 'cols': 30, 'rows': 25}))

    class Meta:
        model = Post
        fields = ['title', 'description', ]


class SearchForm(forms.Form):
    search = forms.CharField()

