
(defun my-cgpa (grades creds)
  (/ (->> (cl-map 'array (lambda (el) (* el (pop grades))) creds)
       (cl-reduce '+))
     (cl-reduce '+ creds)))

