bool isvalidURL(String url) {
  return Uri.parse(url).host == '' ? false : true;
}
