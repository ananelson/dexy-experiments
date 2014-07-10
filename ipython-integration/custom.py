from dexy.filters.templating_plugins import TemplatePlugin

class MyCustomPlugin(TemplatePlugin):
    """
    This is a custom plugin.
    """
    aliases = ['foo']

    def foo_method(self, text):
        return "foo sez: '%s'" % text

    # dict keys returned by run are added to jinja template environment
    def run(self):
        return {
                'foo' : ("foo docs", self.foo_method,)
                }
