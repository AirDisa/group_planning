module ApplicationHelper

  def current_user
    @_current_user ||= session[:current_user_id] &&
                       User.find_by_id(session[:current_user_id])
  end

  def flash_class(level)
    {:notice  => "alert alert-info",
     :success => "alert alert-success",
     :error   => "alert alert-error",
     :alert   => "alert alert-error"}[level]
  end

  def image_options
    [ ['Choose Theme',  "events/default.jpg"   ],
      ['Sporting',      "events/sports.jpg"    ],
      ['Music',         "events/music.jpg"     ],
      ['Nightlife',     "events/nightlife.jpg" ],
      ['Theater',       "events/theater.jpg"   ],
      ['Travel',        "events/travel.jpg"    ] ]
  end
end