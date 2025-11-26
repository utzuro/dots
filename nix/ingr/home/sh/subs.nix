{ ... }:

{
  programs.newsboat = {
    enable = true;
    autoReload = true;
    reloadTime = 30; # minutes
    extraConfig = ''
    '';

    urls = [

      # general
      {
        tags = [ "general" ];
        url = "http://queue.acm.org/rss/feeds/queuecontent.xml";
      }
      {
        tags = [ "general" ];
        url = "http://syndication.thedailywtf.com/TheDailyWtf";
      }
      {
        tags = [ "general" ];
        url = "https://news.ycombinator.com/rss";
      }
      {
        tags = [ "general" ];
        url = "https://xkcd.com/rss.xml";
      }

      # sci / philosophy
      {
        tags = [ "sci" ];
        url = "https://arxiv.org/rss/cs";
      }
      {
        tags = [ "philosophy" ];
        url = "https://dailynous.com/feed/";
      }
      {
        tags = [ "sci" ];
        url = "https://philosophynow.org/rss";
      }
      {
        tags = [ "sci" ];
        url = "https://www.3quarksdaily.com/feed";
      }

      # dev
      {
        tags = [ "dev" ];
        url = "https://blog.rust-lang.org/feed.xml";
      }
      {
        tags = [ "dev" ];
        url = "https://cprss.s3.amazonaws.com/golangweekly.com.xml";
      }
      {
        tags = [ "dev" ];
        url = "https://lists.yoctoproject.org/g/yocto/rss";
      }

      # hacking / security
      {
        tags = [ "hacking" ];
        url = "https://hackerpublicradio.org/rss";
      }
      {
        tags = [ "hacking" ];
        url = "https://hackaday.com/feed/";
      }
      {
        tags = [ "hacking" ];
        url = "https://www.hackthebox.com/rss/blog/red-teaming";
      }
      {
        tags = [ "security" ];
        url = "https://www.reddit.com/r/netsec/.rss";
      }
      {
        tags = [ "security" ];
        url = "https://www.schneier.com/blog/atom.xml";
      }
      {
        tags = [ "reverse" "engineering" ];
        url = "https://www.reddit.com/r/ReverseEngineering/.rss";
      }
      {
        tags = [ "osint" ];
        url = "https://www.reddit.com/r/OSINT/.rss";
      }

      # tech
      {
        tags = [ "tech" ];
        url = "https://hackaday.com/feed/";
      }
      {
        tags = [ "tech" ];
        url = "https://hnrss.org/best";
      }
      {
        tags = [ "tech" ];
        url = "https://hnrss.org/frontpage";
      }
      {
        tags = [ "tech" ];
        url = "https://lobste.rs/rss";
      }
      {
        tags = [ "tech" ];
        url = "https://n-o-d-e.net/feed.xml";
      }
      {
        tags = [ "tech" ];
        url = "https://pinboard.in/popular/feed/";
      }
      {
        tags = [ "tech" ];
        url = "https://rss.nytimes.com/services/xml/rss/nyt/Technology.xml";
      }
      {
        tags = [ "tech" ];
        url = "https://tildes.net/tech/rss";
      }
      {
        tags = [ "tech" ];
        url = "https://www.reddit.com/r/linux/.rss";
      }
      {
        tags = [ "tech" ];
        url = "https://www.reddit.com/r/programming/.rss";
      }
      {
        tags = [ "tech" ];
        url = "http://feeds.arstechnica.com/arstechnica/technology-lab";
      }

      # watch
      {
        tags = [ "watch" ];
        url = "https://github.com/nixos/nixpkgs/releases.atom";
      }
    ];
  };
}

