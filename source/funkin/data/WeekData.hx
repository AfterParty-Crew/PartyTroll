package funkin.data;

import sys.FileSystem;
import funkin.Paths.FreeplaySongMetadata;
import funkin.Paths.ContentMetadata;
import haxe.io.Path;
using StringTools;

typedef WeekMetadata = {
	/**
		Name of the week. 
	**/
	var name:String;
	
	/**
		Any week that isn't 'main' shouldn't be displayed in the story menus. 
	**/
	var category:String;

	/**
		Incase you want a main week to appear in a seperate freeplay category
	**/
	@:optional var freeplayCategory:String;
	
	/**
		Not implemented!
		In case of being a string it would've been checked from a Map from your save file
		as FlxG.save.data.unlocks.get(unlockCondition) maybe
	**/
	var ?unlockCondition:Any;
	
	/**
		Song names of this week.
	**/
	var songs:Array<String>;

	/**
		Difficulties in this week.
		Mainly used for Psych weeks.
	**/
	var ?difficulties:Array<String>;
	
	/**
		Name of the content folder containing this week
	**/
	var ?directory:String;

	/**
	 *  Hides the week in freeplay
	 */
	var ?hideFreeplay:Bool;
}

class WeekData
{
	// public static var chaptersMap:Map<String, WeekMetadata> = new Map();
	public static var weekList:Array<WeekMetadata> = [];
	public static var curWeek:Null<WeekMetadata> = null;

	public static var weekCompleted(get, null):Map<String, Bool>;
	@:noCompletion static function get_weekCompleted() return Highscore.weekCompleted;

	public static function reloadWeekFiles(inFreeplay:Bool = false):Array<WeekMetadata>
	{
		var list:Array<WeekMetadata> = weekList = [];

		#if MODS_ALLOWED
		for (mod => daJson in Paths.getContentMetadata()) {
			if (daJson != null) {
				var loaded_songs:Array<String> = [];

				if (daJson.weeks != null){
					for (week in daJson.weeks) {
						if(inFreeplay && week.hideFreeplay)
							continue;
						
						week.directory = mod;
						if(week.songs != null)
							for (song in week.songs)
								loaded_songs.push(song.toLowerCase().replace(" ", "-"));
						list.push(week);
					}
				}
				if (inFreeplay) {
					if (daJson.freeplaySongs != null){
						var freeplay_week:funkin.data.WeekData.WeekMetadata = {
							name: "Freeplay Songs",
							category: mod + "-freeplay",
							freeplayCategory: mod + "-freeplay",
							unlockCondition: true,
							songs: [],
							difficulties: [],
							directory: mod
							
						}
						var freeplaySongs:Array<FreeplaySongMetadata> = cast daJson.freeplaySongs;
						for (song in freeplaySongs){
							freeplay_week.songs.push(song.name);
							loaded_songs.push(song.name.toLowerCase().replace(" ", "-"));
						}
						
						
						list.push(freeplay_week);
					}
					if (daJson.defaultCategory != null && daJson.defaultCategory.length > 0){
						var default_week:funkin.data.WeekData.WeekMetadata = {
							name: "Default Songs",
							category: mod + "-default_category",
							freeplayCategory: mod + "-default_category",
							unlockCondition: true,
							songs: [],
							difficulties: [],
							directory: mod
						}
						var dir = Paths.mods(mod + "/songs");
						Paths.iterateDirectory(dir, function(file:String) {
							if (FileSystem.isDirectory(haxe.io.Path.join([dir, file]))
								&& !loaded_songs.contains(file.toLowerCase().replace(" ", "-"))) {
			
								default_week.songs.push(file);
								//newSongButton(file, defaultCategory, displayName);
							}
						});
						if (default_week.songs.length > 0)
							list.push(default_week);
					}
				}
			}
		}
		#end

		return list;
	}
}