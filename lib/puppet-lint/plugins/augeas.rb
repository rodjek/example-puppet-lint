class PuppetLint::Plugins::CheckAugeas < PuppetLint::CheckPlugin
  # Public: Check for augeas resources that do not have lens and incl
  # parameters specified and alert on any found.  Augeas resources without
  # these parameters will attempt to parse as much of the filesystem as it can
  # which significantly slow down Puppet runs.
  #
  # Returns nothing.
  check 'augeas_without_lens_incl' do
    lens_found_in_defaults = false
    incl_found_in_defaults = false

    # Check for augeas default parameters
    tokens.select { |r|
      r.type == :CLASSREF && r.value == 'Augeas'
    }.each do |token|
      while true
        # Break out of the loop when we hit a }
        break if token.type == :RBRACE

        # Find all the => tokens inside the default definition block and look
        # at the value of the first non-formatting token before them
        if token.type == :FARROW
          case token.prev_code_token.value
          when 'lens'
            lens_found_in_defaults = true
          when 'incl'
            incl_found_in_defaults = true
          end
        end

        # Move onto the next non-formatting token
        token = token.next_code_token
      end
    end

    # Loop through all the resources in the manifest.
    resource_indexes.each do |resource|
      resource_tokens = tokens[resource[:start]..resource[:end]]

      # Look backwards through all the tokens that came before this resource to
      # find the first { token (at the start of the resource).
      prev_tokens = tokens[0..resource[:start]]
      lbrace_idx = prev_tokens.rindex { |r| r.type == :LBRACE }

      # Get the first non-formatting token before the { token (which will be
      # the resource type)
      resource_type_token = tokens[lbrace_idx].prev_code_token
      if resource_type_token.value == 'augeas'
        # If we couldn't find a default lens value, check inside the resource
        # to see if one is defined there
        unless lens_found_in_defaults
          if resource_tokens.none? { |t| t.type == :NAME && t.value == 'lens' }
            notify :error, {
              :message    => 'augeas resource without a lens parameter',
              :linenumber => resource_type_token.line,
              :column     => resource_type_token.column,
            }
          end
        end

        # If we couldn't find a default incl value, check inside the resource
        # to see if one is defined there
        unless incl_found_in_defaults
          if resource_tokens.none? { |t| t.type == :NAME && t.value == 'incl' }
            notify :error, {
              :message    => 'augeas resource without an incl parameter',
              :linenumber => resource_type_token.line,
              :column     => resource_type_token.column,
            }
          end
        end
      end
    end
  end
end
