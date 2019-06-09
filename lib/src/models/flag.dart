class Flag{
  String _url;
  Flag(this._url);

  String getURL() => this._url;

  String getName() => this._url.split('/').last.split('.').first;
}