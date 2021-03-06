package score;

import datetime.DateTime;
import haxe.Http;
import haxe.Json;

class ScoreClient
{
	private static inline var root:String = "https://score.lc-apps.co.uk/kfp";

	public static function getToken(callback:String->Void):Void
	{
		var req = new Http('$root/token');
		req.async = true;
		req.onData = callback;
		req.onError = function(msg:String)
		{
			callback(null);
		};

		req.request(false);
	}

	public static function submit(token:String, name:String, score:Int, callback:Bool->Void):Void
	{
		var req = new Http('$root');
		req.async = true;
		req.addHeader("Content-Type", "application/json");
		req.setPostData(Json.stringify({
			token: token,
			value: score,
			name: name,
			proof: null
		}));

		req.onStatus = function(status:Int)
		{
			callback(status >= 200 && status <= 299);
		};

		req.request(true);
	}

	public static function listScores(callback:Array<Score>->Void):Void
	{
		var req = new Http('$root');
		req.addParameter("from", (DateTime.now() - Hour(12)).toString());
		req.async = true;

		req.onData = function(data:String)
		{
			var scores:Array<Score> = cast Json.parse(data);
			callback(scores);
		};

		req.onError = function(msg:String)
		{
			callback(null);
		}

		req.request(false);
	}
}
