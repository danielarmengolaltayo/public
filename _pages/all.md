---
layout: page
title: All notes
permalink: /all
---
list all notes  
*preview not available*

<!-- {% assign notes_by_update = site.notes | sort:"last-modified" | reverse %}
{% for note in notes_by_update %}{{ note.last-modified | date: "%Y-%m-%d" }} <a href="{{ note.url }}" class="internal-link-disconnected">{{ note.title }}</a>  
{% endfor %} -->

{% assign notes_by_update = site.notes | sort:"last-modified" | reverse %}
{% assign notes_by_creation = site.notes | sort:"name" | reverse %}
<table>
    <tr>
    <th style="text-align:left; width:85px">created</th>
    <th style="text-align:left; width:85px">modified</th>
    </tr>
{% assign d = false %}
{% for note in notes_by_update %}
    <tr>
        <td>
        {{ note.created }}
        </td>
        <td>
        {% if d %}
            {% if d != note.last-modified %}
                {{ note.last-modified }}
                {% assign d = false %}
            {% endif %}
        {% else %}
            {{ note.last-modified }}
            {% assign d = note.last-modified %}
        {% endif %}
        </td>
        <td><a href="{{ note.url }}" class="internal-link-disconnected" style="color:red">{{ note.title }}</a></td>
    </tr>
{% endfor %}
</table> 

