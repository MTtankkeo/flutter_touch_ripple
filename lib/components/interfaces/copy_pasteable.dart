abstract class CopyPasteable<T extends Object> {
  const CopyPasteable();

  T copyWith();
  T pasteWith(T object);
}
