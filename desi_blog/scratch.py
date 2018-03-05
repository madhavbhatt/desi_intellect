database = sqlite3.connect('db.sqlite3')
connector = database.cursor()
connector.execute('SELECT * FROM webmap_post WHERE idor_status="Pending"')
rows = connector.fetchall()
for row in rows:
    id_num = row[0]
    image_file = row[4]
    old_file = settings.MEDIA_ROOT + "/" + str(image_file)
    filename, file_extension = os.path.splitext(image_file)
    new_image_file = "media/" + str(keygen()) + file_extension
    new_file = settings.MEDIA_ROOT + "/media/" + str(keygen()) + file_extension
    shutil.move(old_file, new_file)
    connector.execute('UPDATE webmap_post SET image = ? WHERE id = ? ', (new_image_file, id_num))
    connector.execute('UPDATE webmap_post SET idor_status = ? WHERE id = ? ', ("Complete", id_num))


class PictureWidget(forms.widgets.Widget):
    def render(self, name, value, attrs=None):
        if str(value) == '':
            html1 = "<img id='id_image' style='display:block' class='rounded float-left d-block'/>"
        else:
            html1 = "<img id='id_image' style='display:block' class='rounded float-left d-block' src='" + settings.MEDIA_URL + str(value) + "'/>"
        return mark_safe(html1)


class MyForm(forms.ModelForm):

    image_container = forms.CharField(required=False, widget=forms.HiddenInput())
    class Meta:
        model = MYMODEL
        fields = '__all__'
        widgets = {
            'image': PictureWidget(),
        }
    def save(self, commit=True):
        # check image_container data
        self.instance.image.delete(False)
        imgdata = self.cleaned_data['image_container'].split(',')
        try:
            ftype = imgdata[0].split(';')[0].split('/')[1]
            fname = slugify(self.instance.title)
            self.instance.image.save('path/%s.%s' % (fname, ftype), ContentFile(imgdata[1].decode("base64")))
        except:
            pass
        return super(MyForm, self).save(commit=commit)