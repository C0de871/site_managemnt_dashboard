abstract class Params {}

class NoParams extends Params {}

class NoBody {}

class TemplateParams extends Params {
  final int templateId;

  TemplateParams({required this.templateId});
}
