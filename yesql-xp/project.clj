(defproject yesql-xp "0.1.0-SNAPSHOT"
  :description "Leveling up with enough experience points in YesQL;"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :plugins [[cider/cider-nrepl "0.9.0-SNAPSHOT"]]
  :dependencies [[org.clojure/clojure "1.6.0"]
                 [org.clojure/tools.nrepl "0.2.7"]
                 [org.clojure/java.jdbc "0.3.3"]
                 [mysql/mysql-connector-java "5.1.32"]
                 [yesql "0.4.0"]])
