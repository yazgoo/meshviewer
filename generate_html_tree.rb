#!/usr/bin/env ruby
def get_tree pattern
    tree = {}
    Dir[pattern].each do |item|
        subtree = tree
        item = item.split("/")[2].sub(/.obj$/, "")
        items = item.split(',')
        items.shift
        items.each_with_index do |key, i|
            subtree[key] ||= i == (items.size - 1) ? item : {}
            subtree = subtree[key]
        end
        subtree = item
    end
    tree
end
def get_html tree, parent
    s = ""
    tree.each do |item, subtree|
        if subtree.instance_of? String
            s+= "<li><a href='javascript:load_mesh(\"#{subtree}\")'>#{item}</a></li>"
        else
            s += "<li>#{item}<ul>#{get_html subtree, item}</ul></li>"
        end
    end
    s
end
puts get_html get_tree('examples/mt7/*.obj'), ''
