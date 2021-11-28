(defun code-review-gitlab--graphql (graphql variables callback)
  (glab-request "POST" "/graphql" nil :payload (json-encode
                                                `(("query" . ,graphql)
                                                  ,@(and variables `(("variables" ,@variables)))))
         (query (code-review-utils--get-graphql 'gitlab 'get-pull-request)))
    (code-review-gitlab--graphql
     query
     `((repo_fullpath . ,(format "%s/%s" owner repo))
       (pr_id . ,number))
     callback)))