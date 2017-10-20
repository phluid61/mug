
class String

  def affix prefix, suffix
    "#{prefix}#{self}#{suffix}"
  end

  def prefix str
    "#{str}#{self}"
  end

  def suffix str
    "#{self}#{str}"
  end



  def affix! prefix, suffix
    replace affix(prefix, suffix)
  end

  def prefix! str
    replace prefix(str)
  end

  def suffix! str
    replace suffix(str)
  end



  def affix? prefix, suffix
    if Regexp === prefix
      md = match(/\A#{prefix}/)
      if md
        rest = md.post_match
      else
        return false
      end
    else
      prefix = prefix.to_s
      if start_with? prefix
        i = prefix.length
        rest = self[i..-1]
      else
        return false
      end
    end
    rest.suffix? suffix
  end

  def prefix? pattern
    if Regexp === pattern
      #match?(/\A#{pattern}/)
      !!(self =~ /\A#{pattern}/)
    else
      start_with? pattern.to_s
    end
  end

  def suffix? pattern
    if Regexp === pattern
      #match?(/#{pattern}\z/)
      !!(self =~ /#{pattern}/\z)
    else
      end_with? pattern.to_s
    end
  end

end

=begin
Copyright (c) 2017, Matthew Kerwin <matthew@kerwin.net.au>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
=end
