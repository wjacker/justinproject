package
{
    public class SyntaxHighlighter
    {
        public static const MULTI_LINE_COMMENTS:RegExp = new RegExp('/\\*[\\s\\S]*?\\*/', 'gm');
        public static const SINGLE_LINE_COMMENTS:RegExp = new RegExp('//.*$', 'gm');
        public static const SINGLE_LINE_PERLCOMMENTS:RegExp = new RegExp('#.*$', 'gm');
        public static const DOUBLE_QUOTED_STRING:RegExp = new RegExp('"(?:\\.|(\\\\\\")|[^\\""\\n])*"','g');
        public static const SINGLE_QUOTED_STRING:RegExp = new RegExp("'(?:\\.|(\\\\\\')|[^\\''\\n])*'", 'g');
        public static const REG_STRING:RegExp = new RegExp('\\/([^\\r])*\\/[gmi]+', 'g');

        private static var ASCRIPT_KEYWORDS:String = "break continue do else for if return while "
            + "as case catch class const default delete extends "
            + "false finally implements import in instanceof interface internal is native new null package "
            + "private protected public super switch this throw to true try typeof use void with "
            + "each namespace include dynamic final native override static abstract boolean byte cast char "
            + "debugger double enum export float goto intrinsic long prototype short synchronized throws to transient "
            + "type virtual volatile";

        private var langHandlerRegistry:Object = {};
        protected var options:Object;
        /*protected var keywords:String;
        protected var regList:Array;*/
        private var code;

        public function SyntaxHighlighter()
        {
            registerLangHandler(sourceDecorator({regexList:
                [new RegexpObject(REG_STRING, "string"),
                    new RegexpObject(MULTI_LINE_COMMENTS, "comment"),
                    new RegexpObject(SINGLE_LINE_COMMENTS, "comment"),
                    new RegexpObject(SINGLE_LINE_PERLCOMMENTS, "comment"),
                    new RegexpObject(DOUBLE_QUOTED_STRING, "string"),
                    new RegexpObject(SINGLE_QUOTED_STRING, "string"),
                    new RegexpObject(new RegExp('<[A-Za-z]*:[A-Za-z]*[ >]+|<\\/[A-Za-z]*:[A-Za-z]*>', 'g'), "mxml"),
                    new RegexpObject(new RegExp('\\bfunction\\b', 'gi'), "function"),
                    new RegexpObject(new RegExp('\\bvar\\b', 'gi'), "var"),
                    new RegexpObject(new RegExp('\\b([\\d]+(\\.[\\d]+)?|0x[a-f0-9]+)\\b', 'gi'), "number"),
                    new RegexpObject(new RegExp('(?!\\@interface\\b)\\@[\\$\\w]+\\b', 'g'), "annotation"),
                    new RegexpObject(new RegExp('\\@interface\\b', 'g'), "keyword"),
                    new RegexpObject(new RegExp(getKeywords(ASCRIPT_KEYWORDS), 'gm'), "keyword")]}), ['as', 'mxml']);
        }

        private function getKeywords(str):String
        {
            return '\\b' + str.replace(/ /g, '\\b|\\b') + '\\b';
        }

        public function highlighterCode(sourceCodeHtml:String, opt_langExtension:String):String
        {
            if (!langHandlerRegistry.hasOwnProperty(opt_langExtension))
            {
                // Treat it as markup if the first non whitespace character is a < and
                // the last non-whitespace character is a >.
                var checkmark:RegExp = /^\s*?</;
                opt_langExtension =
                    checkmark.test(sourceCodeHtml) ? 'default-markup' : 'default-code';
            }

            var result:String = langHandlerRegistry[opt_langExtension].call({}, sourceCodeHtml);
            trace(result);
            return result;
        }

        private function registerLangHandler(handler:Function, fileExtensions:Array):void
        {
            for (var i:int = fileExtensions.length; --i >= 0;)
            {
                var ext:Object = fileExtensions[i];
                if (!langHandlerRegistry.hasOwnProperty(ext))
                {
                    langHandlerRegistry[ext] = handler;
                }
                else
                {
                    trace('cannot override language handler %s', ext);
                }
            }
        }

        private function findValue(... args):String
        {
            var a:Array = args;

            for(var i = 0; i < a.length; i++)
            {
                if(a[i] === null)
                    continue;

                if(a[i] is String &&  a[i] != '')
                    return a[i] + '';

                if(a[i] is Object && a[i].value != '')
                    return a[i].value + '';
            }
            return null;
        }

        private function isOptionSet(value:String, list:String):Boolean
        {
            for(var i = 0; i < list.length; i++)
                if(list[i] == value)
                    return true;

            return false;
        }

        private function getOptionValue(name:String, list:String, defaultValue:int):int
        {
            var regex = new RegExp('^' + name + '\\[(\\w+)\\]$', 'gi');
            var matches = null;

            for(var i = 0; i < list.length; i++)
                if((matches = regex.exec(list[i])) != null)
                    return matches[1];

            return defaultValue;
        }

        /*private function findTagsByName(list:Array, name:String, tagName:String)
        {
            var tags = document.getElementsByTagName(tagName);

            for(var i = 0; i < tags.length; i++)
                if(tags[i].getAttribute('name') == name)
                    list.push(tags[i]);
        }
*/

        private function syntaxHightlightCode(sourceCodeHtml:String, opt_langExtension:String):String
        {
            if (!langHandlerRegistry.hasOwnProperty(opt_langExtension))
            {
                // Treat it as markup if the first non whitespace character is a < and
                // the last non-whitespace character is a >.
                var checkmark:RegExp = /^\s*?</;
                opt_langExtension = checkmark.test(sourceCodeHtml) ? 'default-markup' : 'default-code';
            }
            return langHandlerRegistry[opt_langExtension].call(sourceCodeHtml);
        }
        private function trim(value:String):String
        {
            return value.replace(/^\s*(.*?)[\s\n]*$/g, '$1');
        }

        private function fixForBlogger(value:String):String
        {
            return (options.isBloggerMode == true) ? value.replace(/<br\s*\/?>|&lt;br\s*\/?&gt;/gi, '\n') : value;
        }

        private function unindent(value:String):String
        {
            var lines:Array = fixForBlogger(value).split('\n');
            var indents:Array = new Array();
            var regex:RegExp = new RegExp('^\\s*', 'g');
            var min:int = 10000;

            // go through every line and check for common number of indents
            for(var i = 0; i < lines.length && min > 0; i++)
            {
                if(trim(lines[i]).length === 0)
                    continue;

                var matches = regex.exec(lines[i]);

                if(matches != null && matches.length > 0)
                    min = Math.min(matches[0].length, min);
            }

            // trim minimum common number of white space from the begining of every line
            if(min > 0)
                for(var i = 0; i < lines.length; i++)
                    lines[i] = lines[i].substr(min);

            return lines.join('\n');
        }

        private function chop(value:String):String
        {
            return value.replace(/\n*$/, '').replace(/^\n*/, '');
        }

        private function copy(string:String, pos1:Number, pos2:Number):String
        {
            return string.substr(pos1, pos2 - pos1);
        }

        private function insertSpaces(line:String, pos:Number, count:Number):String
        {
            var left	= line.substr(0, pos);
            var right	= line.substr(pos + 1, line.length);	// pos + 1 will get rid of the tab
            var spaces	= '';

            for(var i = 0; i < count; i++)
                spaces += ' ';

            return left + spaces + right;
        }

        private function processSmartTabs(code:String):String
        {
            function processLine(line:String, tabSize:int):String
            {
                if(line.indexOf(tab) == -1)
                    return line;

                var pos = 0;

                while((pos = line.indexOf(tab)) != -1)
                {
                    // This is pretty much all there is to the 'smart tabs' logic.
                    // Based on the position within the line and size of a tab,
                    // calculate the amount of spaces we need to insert.
                    var spaces = tabSize - pos % tabSize;

                    line = insertSpaces(line, pos, spaces);
                }
                return line;
            }

            var lines:Array	= code.split('\n');
            var result:String = '';
            var tabSize:int	= 4;
            var tab:String = '\t';

            for(var i = 0; i < lines.length; i++)
                result += processLine(lines[i], tabSize) + '\n';

            return result;
        }

        private function addBit(str, css):String
        {
            if(str === null || str.length === 0)
                return "";

            var result:String = "";

            //	str = str.replace(/&/g, '&amp;');
            str = str.replace(/ /g, '&nbsp;');
            str = str.replace(/</g, '&lt;');
            //	str = str.replace(/&lt;/g, '<');
            //	str = str.replace(/>/g, '&gt;');
            str = str.replace(/\n/gm, '&nbsp;<br>');

            // when adding a piece of code, check to see if it has line breaks in it
            // and if it does, wrap individual line breaks with span tags
            if(css != null)
            {
                if((/br/gi).test(str))
                {
                    var lines = str.split('&nbsp;<br>');

                    for(var i = 0; i < lines.length; i++)
                    {
                        result += "<span class='"+ css +"'>" + lines[i] + "</span>"

                        // don't add a <BR> for the last line
                        if(i + 1 < lines.length)
                            result += "<br/>"
                    }
                }
                else
                {
                    result += "<span class='"+ css +"'>" + str + "</span>"
                }
            }
            else
            {
                result += "<span>" + str + "</span>"
            }
            return result;
        }

        private function sourceDecorator(options:Object):Function
        {
            this.options = options;
            return function(source:String):String
            {
                function processRegexList():void
                {
                    if(options.regexList)
                    {
                        for(var i = 0; i < options.regexList.length; i++)
                            getMatches(options.regexList[i] as RegexpObject);
                    }
                }

                function getMatches(regexExp:RegexpObject):void
                {
                    var match:Object = null;

                    while((match = regexExp.regexp.exec(code)) != null)
                        matches[matches.length] = new Match(match[0], match.index, regexExp.type);
                }

                function isInside(match:Match):Boolean
                {
                    if(match === null || match.length === 0)
                        return false;

                    for(var i = 0; i < matches.length; i++)
                    {
                        var c = matches[i];

                        if(c === null)
                            continue;

                        if((match.index > c.index) && (match.index < c.index + c.length))
                            return true;
                    }

                    return false;
                }

                // This function returns a portions of the string from pos1 to pos2 inclusive
                var pos	= 0;
                if(source === null)
                    source = '';

                var result:String = "";

                //this.originalCode = source;
                code = chop(unindent(source));
                var matches:Array = new Array();

                // replace tabs with spaces
                if(options.tabsToSpaces == true)
                    code = processSmartTabs(this.code);

                processRegexList();

                // if no matches found, add entire code as plain text
                if(matches.length == 0)
                {
                    result += addBit(code, null);
                    //switchToList();
                    return "";
                }

                // sort the matches
                matches = matches.sort(sortCallback);

                // The following loop checks to see if any of the matches are inside
                // of other matches. This process would get rid of highligted strings
                // inside comments, keywords inside strings and so on.
                for(var i = 0; i < matches.length; i++)
                    if(isInside(matches[i]))
                        matches[i] = null;

                // Finally, go through the final list of matches and pull the all
                // together adding everything in between that isn't a match.
                for(var i = 0; i < matches.length; i++)
                {
                    var match = matches[i];

                    if(match === null || match.length === 0)
                        continue;

                    result += addBit(copy(code, pos, match.index), null);
                    result += addBit(match.value, match.css);

                    pos = match.index + match.length;
                }

                result += addBit(code.substr(pos), null);
                return result;

            }
        }

        private function sortCallback(m1:Match, m2:Match):int
        {
            // sort matches by index first
            if(m1.index < m2.index)
                return -1;
            else if(m1.index > m2.index)
                return 1;
            else
            {
                // if index is the same, sort by length
                if(m1.length < m2.length)
                    return -1;
                else if(m1.length > m2.length)
                    return 1;
            }
            return 0;
        }

        /*private function switchToList():void
        {
            // thanks to Lachlan Donald from SitePoint.com for this <br/> tag fix.
            var html = this.div.innerHTML.replace(/<(br)\/?>/gi, '\n');
            var lines = html.split('\n');

            if(this.addControls == true)
                this.bar.appendChild(dp.sh.Toolbar.Create(this));

            // add columns ruler
            if(this.showColumns)
            {
                var div = this.CreateElement('div');
                var columns = this.CreateElement('div');
                var showEvery = 10;
                var i = 1;

                while(i <= 150)
                {
                    if(i % showEvery === 0)
                    {
                        div.innerHTML += i;
                        i += (i + '').length;
                    }
                    else
                    {
                        div.innerHTML += '&middot;';
                        i++;
                    }
                }

                columns.className = 'cumns';
                columns.appendChild(div);
                this.bar.appendChild(columns);
            }

            for(var i = 0; i < lines.length - 1; i++)
            {
                var li = this.CreateElement('LI');
                var span = this.CreateElement('SPAN');

                // uses .line1 and .line2 css styles for alternating lines
                li.className = (i % 2 === 0) ? 'alt' : '';
                span.innerHTML = lines[i] + '&nbsp;';

                li.appendChild(span);
                this.ol.appendChild(li);
            }

            this.div.innerHTML	= '';
        }*/

    }
}