require "pathname"

require "ffi-xattr"
require "cfpropertylist"

module FinderUtils
  TAG_KEY = "com.apple.metadata:_kMDItemUserTags".freeze

  class Tag
    COLORS = {
      white: 0,
      gray: 1,
      green: 2,
      purple: 3,
      blue: 4,
      yellow: 5,
      red: 6,
      orange: 7
    }.freeze

    INVERSE_COLORS = COLORS.values.zip(COLORS.keys).to_h.freeze

    attr_accessor :name, :color

    def initialize name:, color: :white
      color = INVERSE_COLORS[ color ] if color.is_a? Numeric

      fail ArgumentError, "Color must be one of #{ COLORS.keys }, got `#{ color }' instead!" unless COLORS.key? color

      @name = name.to_s
      @color = color
    end

    # MacOS Seems to store tags in the plist using the format:
    # "<name>\n<color>" Where <color> is a range of 0-7, representing the
    # colors listed in Tag::COLORS
    def to_s
      [name, COLORS[ color ]].join("\n")
    end

    def inspect
      [name, color].join ":"
    end

    def to_binary binary
      CFPropertyList::CFString.new(to_s).to_binary(binary)
    end

    def == other
      name == other.name && color == other.color
    end

    alias_method :eql?, :==
  end

  refine ::Pathname do
    # Extended attributes can change between operations on them, so don't cache
    # the object.
    def xattrs
      Xattr.new(to_s)
    end

    def xattr_plist key
      CFPropertyList::List.new data: xattrs[key]
    end

    def tags
      tag_attr = xattr_plist(TAG_KEY).value
      return [] unless tag_attr
      tag_attr.value
        .map do |attr|
          tag_tuples = attr.value.split "\n"
          Tag.new name: tag_tuples[0], color: tag_tuples[1].to_i
        end
    end

    def tags= tags
      xattrs["com.apple.metadata:_kMDItemUserTags"] = xattr_plist(TAG_KEY).tap do |plist|
        plist.value = CFPropertyList::CFArray.new tags
      end.to_str
    end

    alias_method :set_tags, :tags=

    def merge_tags tags
      existing_tags = tags
      new_tags = existing_tags.concat(tags).uniq
      set_tags new_tags
    end

    def reset_tags!
      set_tags []
    end

    def set_tag name, color:
      new_tags = tags
      new_tags << Tag.new(name: name, color: color)

      set_tags new_tags
    end

    def remove_tag name
      new_tags = tags
      new_tags.delete_if { |tag| tag.name == name }

      set_tags new_tags
    end

    def tag? name
      return tags.any? { |tag| tag.name == name } if name.is_a? String
      tags.include? name
    end
  end
end
