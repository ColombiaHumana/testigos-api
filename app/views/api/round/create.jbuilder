# frozen_string_literal: true

json.status @result.id_previously_changed? ? 'created' : 'show'
json.votes @result.votes
