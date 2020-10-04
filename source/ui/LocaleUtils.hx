package ui;

#if html5
import js.Browser;
#end

class LocaleUtils
{
	public static function selectDefaultLocale(supported:Array<String>):String
	{
		var sup:Array<Locale> = mapAll(supported);
		var pref:Array<Locale> = mapAll(getPreferred());

		var best:Locale = null;
		var bestVal:Int = 0;

		for (p in pref)
		{
			for (s in sup)
			{
				var val:Int = p.language == s.language ? 1 : 0;
				if (val == 0)
				{
					continue;
				}

				if (p.region == s.region)
				{
					val = 2;
				}

				if (val > bestVal)
				{
					bestVal = val;
					best = s;
				}
			}

			if (best != null)
			{
				return best.language + "-" + best.region.toUpperCase();
			}
		}

		return null;
	}

	private static function mapAll(rawLocale:Array<String>):Array<Locale>
	{
		var locale:Array<Locale> = new Array<Locale>();
		for (r in rawLocale)
		{
			var rsp = r.split("-");
			locale.push({
				language: rsp[0].toLowerCase(),
				region: rsp.length > 1 ? rsp[1].toLowerCase() : null
			});
		}
		return locale;
	}

	private static function getPreferred():Array<String>
	{
		#if html5
		return getPreferred_html5();
		#end

		return [];
	}

	#if html5
	private static function getPreferred_html5():Array<String>
	{
		return Browser.navigator.languages;
	}
	#end
}

typedef Locale =
{
	var language:String;
	var region:String;
};
