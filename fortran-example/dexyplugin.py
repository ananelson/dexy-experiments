from dexy.filter import DexyFilter
import re

class RemovePrintStatements(DexyFilter):
    """
    Custom filter which strips out lines which just print comments.
    """
    aliases = ['fclean']

    _settings = {
            'input-extensions' : ['.f'],
            'output-extensions' : ['.f'],
            }

    def process_text(self, input_text):
        output_text = ""
        section_delim = re.compile("^\s*print \*, \"###")
        for line in input_text.splitlines():
            if not re.match(section_delim, line):
                output_text += "%s\n" % line
            else:
                print "skipping line", line
        return output_text
