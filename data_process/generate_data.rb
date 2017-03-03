require 'rest-client'
require 'json'

MY_PLAYLIST_ID = 36552207

module ApiModule
  #处理get请求的uri
  def self.parseGetUrl(url)
    response = RestClient.get url
    case response.code
      when 200
        return JSON.parse(response)
      else
        return nil
    end
    return nil
  end

  def self.parsePostUrl(url, data)
    response = RestClient.post url, data
    case response.code
      when 200
        return JSON.parse(response)
      else
        return nil
    end
    return nil
  end
  
  def self.getMusicInfo(music_id)
  	url = "http://music.163.com/api/song/detail/?id=#{music_id}&ids=[#{music_id}]"
  	result = parseGetUrl(url)
  end

  def self.getArtistAlbum(artist_id, limit)
  	url = "http://music.163.com/api/artist/albums/#{artist_id}?limit=#{limit}"
  	result = parseGetUrl(url)
  end

  def self.getAlbumInfo(album_id)
  	url = "http://music.163.com/api/album/#{album_id}"
  	result = parseGetUrl(url)
  end

  def self.getPlaylistInfo(playlist_id)
  	url = "http://music.163.com/api/playlist/detail?id=#{playlist_id}"
  	result = parseGetUrl(url)
  end

  def self.getLyricInfo(music_id)
  	url = "http://music.163.com/api/song/lyric?os=pc&id=#{music_id}&lv=-1&kv=-1&tv=-1"
  	result = parseGetUrl(url)
  end

  def self.getMvInfo(mv_id)
  	url = "http://music.163.com/api/mv/detail?id=#{mv_id}&type=mp4"
  	result = parseGetUrl(url)
  end

  def self.generateSongJson
  	file = File.new('../data/static_data.json','w+')
  	result = getPlaylistInfo(MY_PLAYLIST_ID)
  	if result["code"] == 200
      result = result["result"]
      music_list = result["tracks"]
      file.write("var my_favorite_song_list = ")
      # file.write(JSON.pretty_generate(music_list))
      file.write(JSON.pretty_generate(music_list))
      file.write(";")
  	else
      puts "163 music API error"
    end
    file.close
    puts "File closed"
  end

end



# file = File.new('songs.json', 'w')

