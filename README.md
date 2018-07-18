# EnToZh
Translate english to chinese

## Usage
```ruby
#include
class ApplicationRecord < ActiveRecord::Base
  include EnToZh::Translate
end

#using in Model/Controller, only except english character
response.parsed_response["basic"]["explains"] # chinese translation
response.parsed_response["basic"]["us-phonetic"] # american phonetic
response.parsed_response["basic"]["uk-phonetic"] # english phonetic
response.parsed_response["basic"]["uk-speech"] #english phonetic address
response.parsed_response["basic"]["us-speech"] #american phonetic address
```
## Example
```ruby
def interpret
  name = params[:name].strip
  tag_id = params[:word][:tag_id]
  if @word  = current_user.words.find_by(name: name)
    @word.update(updated_at: Time.now, tag_id: tag_id)
    redirect_to word_path(@word)
  elsif @word  = Word.find_by(name: name)
    @word = current_user.words.create(
      name: @word.name,
      uk: @word.uk,
      us: @word.us,
      chinese: @word.chinese,
      uk_voice: @word.uk_voice,
      us_voice: @word.us_voice,
      tag_id: tag_id
      )
    redirect_to word_path(@word)
  else
    response = Word.translate(name)
    if response == "net_error"
      flash[:danger] = "翻译功能暂时不能用"
      redirect_to root_path
    elsif (response.parsed_response["basic"] == nil) || !(/[a-zA-Z-]/ =~ name)
      flash[:danger] = "不存在该英文单词"
      redirect_to root_path
    else
      @word = current_user.words.create(
        name: name,
        tag_id: tag_id,
        chinese: response.parsed_response["basic"]["explains"].map{|str| str.gsub(/\s+/, "")}.join(" "),
        us: response.parsed_response["basic"]["us-phonetic"]==nil ? nil : "["+response.parsed_response["basic"]["us-phonetic"]+"]",
        uk: response.parsed_response["basic"]["uk-phonetic"]==nil ? nil : "["+response.parsed_response["basic"]["uk-phonetic"]+"]",
        uk_voice: response.parsed_response["basic"]["uk-speech"],
        us_voice: response.parsed_response["basic"]["us-speech"]
        )
      redirect_to word_path(@word)
    end
  end
end
```


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'en_to_zh', git: 'git@github.com:Jayzen/en_to_zh.git'
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
