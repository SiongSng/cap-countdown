enum CAPSubject {
  chinese('Chinese', '國文科'),
  englishReading('English', '英文科（閱讀）'),
  englishListening('Listening', '英文科（聽力）'),
  math('Math', '數學科'),
  nature('Nature', '自然科'),
  society('Society', '社會科');

  final String id;
  final String chineseName;

  const CAPSubject(this.id, this.chineseName);
}
