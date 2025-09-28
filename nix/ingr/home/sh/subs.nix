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
        url = "https://news.ycombinator.com/rss";
      }
      {
        tags = [ "general" ];
        url = "https://xkcd.com/rss.xml";
      }
      {
        tags = [ "general" ];
        url = "http://syndication.thedailywtf.com/TheDailyWtf";
      }

      # tech
      {
        tags = [ "tech" ];
        url = "https://www.reddit.com/r/programming/.rss";
      }
      {
        tags = [ "tech" ];
        url = " hackaday.com/feed";
      }
      {
        tags = [ "tech" ];
        url = "https://hnrss.org/frontpage";
      }
      {
        tags = [ "tech" ];
        url = "https://hackaday.com/feed/";
      }
      {
        tags = [ "tech" ];
        url = "http://feeds.arstechnica.com/arstechnica/technology-lab";
      }
      {
        tags = [ "tech" ];
        url = "https://rss.nytimes.com/services/xml/rss/nyt/Technology.xml";
      }
      {
        tags = [ "tech" ];
        url = "https://www.reddit.com/r/linux/.rss";
      }
      {
        tags = [ "tech" ];
        url = "https://lobste.rs/rss";
      }
      {
        tags = [ "hacking" ];
        url = "https://www.hackthebox.com/rss/blog/red-teaming"; # or all-content
      }
      {
        tags = [ "hacking" ];
        url = "https://hackerpublicradio.org/rss"; # hypothetical feed
      }

      {
        tags = [ "hacking" ];
        url = "https://hackaday.com/feed/";
      }

      # dev
      {
        tags = [ "dev" ];
        url = "https://cprss.s3.amazonaws.com/golangweekly.com.xml";
      }
      {
        tags = [ "dev" ];
        url = "https://blog.rust-lang.org/feed.xml";
      }
      {
        tags = [ "dev" ];
        url = "https://lists.yoctoproject.org/g/yocto/rss";
      }

      # sci
      {
        tags = [ "sci" ];
        url = "http://queue.acm.org/rss/feeds/queuecontent.xml";
      }
      {
        tags = [ "sci" ];
        url = "https://arxiv.org/rss/cs";
      }
      {
        tags = [ "sci" ];
        url = "https://www.3quarksdaily.com/feed";
      }
      {
        tags = [ "sci" ];
        url = "https://philosophynow.org/rss";
      }
      {
        tags = [ "philosophy" ];
        url = "https://dailynous.com/feed/";
      }
      {
        tags = [ "philosophy" ];
        url = "https://www.3quarksdaily.com/feed";
      }

      # keep an eye on
      {
        tags = [ "watch" ];
        url = "https://github.com/nixos/nixpkgs/releases.atom";
      }
    ];
  };
}
